//
//  Presentable.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import UIKit

protocol Presentable: NSObject, AnyObject {
  func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
  
  func toPresent() -> UIViewController? {
    return self
  }
    
}
