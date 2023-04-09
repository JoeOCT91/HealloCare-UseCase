//
//  AnyViewModel.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation
import Combine

protocol AnyViewModel: AnyObject {
    var loadingStatePublisher: AnyPublisher<LoadingState, Never> { get }
    var messagingStatePublisher:  AnyPublisher<MessagingState, Never> { get }
}

enum LoadingState {
    case onLoading(_ loadingType: LoadingType)
    case onFinishedLoading(_ loadingType: LoadingType)
}

enum LoadingType {
    case normal
    case custom(_ type: String)
}

enum MessagingState {
    case success(_ message: String)
    case error(_ message: String)
    
    var stateTitle: String {
        switch self {
        case.error:
            return "L10n.onFailure"
        case .success:
            return "L10n.onSuccess"
        }
    }
}


