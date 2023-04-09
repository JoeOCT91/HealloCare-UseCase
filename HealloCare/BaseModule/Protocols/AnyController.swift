//
//  AnyController.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation
import Combine

protocol AnyController: AnyObject, Presentable {
    var onAccountTapPublisher: PassthroughSubject<Void, Never> { get }
}
