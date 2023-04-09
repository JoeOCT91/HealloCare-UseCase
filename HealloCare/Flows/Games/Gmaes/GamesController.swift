//
//  GamesController.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import UIKit
import Combine

protocol GamesControllerOutput: AnyController {
    var onGameDetailsTapPublisher: PassthroughSubject<GameModel, Never> { get }
}

class GamesController: BaseViewController, GamesControllerOutput {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Coordinator helpers ...
    //----------------------------------------------------------------------------------------------------------------
    var onGameDetailsTapPublisher = PassthroughSubject<GameModel, Never>()
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Properties ...
    //----------------------------------------------------------------------------------------------------------------
    private enum Section: Hashable {
        case main
    }
    
    private typealias DataSource = UITableViewDiffableDataSource<Section, GameModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, GameModel>
    private var dataSource: DataSource!
    
    private var viewModel: GamesViewModelProtocol
    private var contentView: GamesView!
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    typealias HomeSearchHandler =  (SearchResultControllerOutput & UISearchResultsUpdating & Presentable)
    init(viewModel: GamesViewModelProtocol, searchResultHandler: HomeSearchHandler) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
        configureNavigationBarSearchController(searchResultsHandler: searchResultHandler)
    }
    
    private func configureNavigationBarSearchController(searchResultsHandler: HomeSearchHandler) {
        let searchResultsController = searchResultsHandler.toPresent()
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsHandler
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.contentView = GamesView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = L10n.games
        configureDataSource()
        bindToDataFlowDownStream()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: contentView.tableView, cellProvider: { [unowned self] tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withClass: GameTableViewCell.self)
            cell.tapSubscriptions = cell.tapPublisher.sink(receiveValue: { [unowned self] _ in
                onGameDetailsTapPublisher.send(itemIdentifier)
            })
            cell.configure(with: itemIdentifier)
            return cell
        })
    }
    
    private func bindToDataFlowDownStream() {
        bindToGamesListDataFlowDownStream()
        bindToUserInteractionsAndUIChanges()
    }
    
    private func bindToGamesListDataFlowDownStream() {
        viewModel.gamesListPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] gamesList in
                guard let self else { return }
                var snapshot = Snapshot()
                snapshot.appendSections([.main])
                snapshot.appendItems(gamesList, toSection: .main)
                self.dataSource.apply(snapshot)
            }.store(in: &subscriptions)
    }
    
    private func bindToUserInteractionsAndUIChanges() {
        bindTotableViewWillAppearCellPublisherDownStream()
    }
    
    private func bindTotableViewWillAppearCellPublisherDownStream() {
        contentView.tableView
            .willDisplayCellPublisher
            .sink { [weak self] (cell, indexPath) in
                guard let self else { return }
                viewModel.fetchDataIfNeeded(for: indexPath)
            }.store(in: &subscriptions)
    }
}
