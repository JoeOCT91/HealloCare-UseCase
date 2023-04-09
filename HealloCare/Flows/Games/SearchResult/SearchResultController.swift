//
//  SearchResultController.swift
//  heallocare
//
//  Created by Yousef Moahmed on 09/04/2023.
//

import UIKit
import Combine

protocol SearchResultControllerOutput: AnyController {
    
}

class SearchResultController: BaseViewController, SearchResultControllerOutput {
    
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
    
    private var viewModel: SearchResultViewModelProtocol
    private var contentView: SearchResultView!
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------

    init(viewModel: SearchResultViewModelProtocol) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.contentView = SearchResultView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        viewModel.searchResultPublisher
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

    }
}

extension SearchResultController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = false
        searchController.searchBar.delegate = self
        self.viewModel.searchKeyword = searchController.searchBar.text
    }
}

extension SearchResultController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.resetSearch()
    }
}
