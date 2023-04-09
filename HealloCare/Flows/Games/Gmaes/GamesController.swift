//
//  GamesController.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation

protocol GamesControllerOutput: AnyController {
    
}

class GamesController: BaseViewController, GamesControllerOutput {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.title = L10n.games
    }
    
}
