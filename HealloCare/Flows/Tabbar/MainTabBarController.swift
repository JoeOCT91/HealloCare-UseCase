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
            return "Games"
        case .favorites:
            return "Favorites"
        }
    }
//
//    var selected: UIImage {
//        switch self {
//        case .explore:
//            return Asset.exploreSelected.image
//        case .translation:
//            return Asset.translationSelected.image
//        case .touters:
//            return Asset.tutorsSelected.image
//        case .myCourses:
//            return Asset.myCoursesSelected.image
//        case .account:
//            return Asset.accountSelected.image
//        }
//    }
//
//    var deselected: UIImage {
//        switch self {
//        case .explore:
//            return Asset.exploreDeselected.image
//        case .translation:
//            return Asset.translationDeselected.image
//        case .touters:
//            return Asset.tutorsDeselected.image
//        case .myCourses:
//            return Asset.myCoursesDeselected.image
//        case .account:
//            return Asset.accountDeselected.image
//        }
//    }
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
//        self.setValue(mainTabBar, forKey: "tabBar")
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let defaultHeight = tabBar.frame.height
        let addingToHeight: CGFloat = 0
        tabBar.frame.size.height = defaultHeight + addingToHeight
        tabBar.frame.origin.y = view.frame.height - (defaultHeight + addingToHeight)
        navigationControllers.forEach { nav in
            self.onViewDidLoadNavigationControllers.send(nav)
        }
        onViewDidLoadNavigationControllers.send(completion: .finished)
    }
}
