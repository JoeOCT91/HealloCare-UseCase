//
//  FavoriteController.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import UIKit
import Combine

protocol FavoritesControllerOutput: AnyController {
    var onGameDetailsTapPublisher: PassthroughSubject<GameModel, Never> { get }
}

class FavoritesController: BaseViewController, FavoritesControllerOutput {
    
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
    
    private var viewModel: FavoritesGamesViewModelProtocol
    private var contentView: FavoritesView!
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    
    init(viewModel: FavoritesGamesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.contentView = FavoritesView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        bindToDataFlowDownStream()
        navigationItem.title = L10n.games
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.refreshFavorites()
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
        bindToFavoritesEmptyStateDownStream()
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
    
    private func bindToFavoritesEmptyStateDownStream() {
        viewModel.isFavoritesEmpty
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                self.contentView.setEmptyFavoritesPlaceHolderVisibility(state: state)
            }.store(in: &subscriptions)
    }
}
