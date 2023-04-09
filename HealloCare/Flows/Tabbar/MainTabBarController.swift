//
//  MainTabBarController.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import UIKit
import Combine

enum TabBarNavigationIdentifier: Equatable, CaseIterable {
    
    case games
    case favorites
    
    var title: String {
        switch self {
        case .games:
            return L10n.games
        case .favorites:
            return L10n.favourites
        }
    }

    var selected: UIImage {
        switch self {
        case .games:
            return Asset.gamesSelected.image
        case .favorites:
            return Asset.favorites.image
        }
    }

    var deselected: UIImage {
        switch self {
        case .games:
            return Asset.gamesSelected.image
        case .favorites:
            return Asset.favoritesSelected.image
        }
    }
}

protocol TabBarControllerOutput: Presentable {
    var onViewDidLoadNavigationControllers: PassthroughSubject<BaseUINavigationController, Never> { get }
}

class MainTabBarController: UITabBarController, TabBarControllerOutput {
    
    var onViewDidLoadNavigationControllers = PassthroughSubject<BaseUINavigationController, Never>()
    private var navigationControllers: [BaseUINavigationController]
    
    init(viewControllers: [BaseUINavigationController]) {
        self.navigationControllers = viewControllers
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationControllers.forEach { nav in
            self.onViewDidLoadNavigationControllers.send(nav)
        }
        onViewDidLoadNavigationControllers.send(completion: .finished)
    }
}
