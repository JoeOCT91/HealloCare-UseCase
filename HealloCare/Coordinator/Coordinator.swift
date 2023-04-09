//
//  Coordinator.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation
import Combine

class Coordinator: AnyCoordinator {
    
    var subscriptions = Set<AnyCancellable>()
    var childCoordinators: [AnyCoordinator] = []
    
    func start() {
    }
    
    // add only unique object
    func addDependency(_ coordinator: AnyCoordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: AnyCoordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
        else { return }
        
        // Clear child-coordinators recursively
        if let coordinator = coordinator as? Coordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter({ $0 !== coordinator })
                .forEach({ coordinator.removeDependency($0) })
        }
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}
