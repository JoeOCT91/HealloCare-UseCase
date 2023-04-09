//
//  BaseViewModel \.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation
import Combine

class BaseViewModel: AnyViewModel {
    
    @Published var messagingState: MessagingState?
    var messagingStatePublisher: AnyPublisher<MessagingState, Never> {
        $messagingState
            .compactMap({$0})
            .eraseToAnyPublisher()
    }
    
    @Published var loadingState: LoadingState?
    var loadingStatePublisher: AnyPublisher<LoadingState, Never> {
        $loadingState
            .compactMap({$0})
            .eraseToAnyPublisher()
    }

    var subscriptions = Set<AnyCancellable>()
    
}
