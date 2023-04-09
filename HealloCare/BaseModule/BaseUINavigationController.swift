//
//  BaseUINavigationController.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import UIKit

class BaseUINavigationController: UINavigationController {
    
    let navigationIdentifier: TabBarNavigationIdentifier?
    
    init(navigationIdentifier: TabBarNavigationIdentifier? = nil) {
        self.navigationIdentifier = navigationIdentifier
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
}
