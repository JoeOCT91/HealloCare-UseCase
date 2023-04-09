//
//  GameDetailsController.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import UIKit
import Combine

protocol GameDetailsControllerOutput: AnyController {
}

class GameDetailsController: BaseViewController, GameDetailsControllerOutput {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Coordinator helpers ...
    //----------------------------------------------------------------------------------------------------------------
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Properties ...
    //----------------------------------------------------------------------------------------------------------------
    private var viewModel: GameDetailsViewModelProtocol
    private var contentView: GameDetailsView!
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------

    init(viewModel: GameDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        contentView = GameDetailsView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFavoriteButtonToNavBar()
        bindToDataFlowDownStream()
        bindToUserInteractionsDownStreams()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func addFavoriteButtonToNavBar() {
        let item = UIBarButtonItem(customView: contentView.favoriteButton)
        navigationItem.rightBarButtonItems = [item]
    }

    private func bindToDataFlowDownStream() {
        bindToGameDataFlowDownStream()
        bindToGameFavoriteStateDownStream()
    }
    
    private func bindToGameDataFlowDownStream() {
        viewModel.gameDetailsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] gameModel in
                guard let self else { return }
                contentView.configureView(with: gameModel)
            }.store(in: &subscriptions)
    }
    
    private func bindToGameFavoriteStateDownStream() {
        viewModel.isFavoritePublisher
            .receive(on: RunLoop.main)
            .sink { [unowned self] state in
                contentView.favoriteButton.isSelected = state
            }.store(in: &subscriptions)
    }
    
    private func bindToUserInteractionsDownStreams() {
        bindToFavoriteTapPublisherDownStream()
    }
    
    private func bindToFavoriteTapPublisherDownStream() {
        contentView.favoriteButton
            .tapPublisher
            .sink { [unowned self] _ in
                viewModel.changeGameFavoriteState()
            }.store(in: &subscriptions)
    }
}
