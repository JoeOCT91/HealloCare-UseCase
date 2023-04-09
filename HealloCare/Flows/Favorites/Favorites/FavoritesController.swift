//
//  FavoriteController.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation

protocol FavoritesControllerOutput: AnyController {
    
}

class FavoriteController: BaseViewController, FavoritesControllerOutput {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        navigationItem.title = L10n.games
    }
    
}
