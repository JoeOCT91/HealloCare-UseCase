//
//  SearchResultViewModel.swift
//  heallocare
//
//  Created by Yousef Moahmed on 09/04/2023.
//

import Foundation

protocol SearchResultViewModelProtocol: AnyViewModel {
    var searchKeyword: String? { get set }
    var searchResultPublisher: Published<[GameModel]>.Publisher { get }
    
    func resetSearch()
}

class SearchResultViewModel: BaseViewModel, SearchResultViewModelProtocol {
    
    @Published private var gamesResultList = [GameModel]()
    @Published var searchKeyword: String?
    var searchResultPublisher: Published<[GameModel]>.Publisher { $gamesResultList }
    private let searchGamesUseCase: SearchGamesUseCase
    private var page: Int = 1
    
    init(searchGamesUseCase: SearchGamesUseCase) {
        self.searchGamesUseCase = searchGamesUseCase
        super.init()
        bindToSearchKeywordDownStream()
    }
    
    private func bindToSearchKeywordDownStream() {
        $searchKeyword
            .compactMap({$0})
            .filter({$0.count > 3})
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.current)
            .sink { [unowned self] keyWord in
                page = 1
                gamesResultList.removeAll()
                searchGames(for: keyWord, page: page)
            }.store(in: &subscriptions)
    }
    
    private func searchGames(for game: String, page: Int) {
        searchGamesUseCase.searchGames(for: game, at: page)
            .sink { completion in
                debugPrint("Task has been completed \(completion)")
            } receiveValue: { [weak self] gamesList in
                guard let self else { return }
                gamesResultList.append(contentsOf: gamesList)
            }.store(in: &subscriptions)
    }
    
    func resetSearch() {
        searchKeyword = nil
        gamesResultList.removeAll()
    }
}
