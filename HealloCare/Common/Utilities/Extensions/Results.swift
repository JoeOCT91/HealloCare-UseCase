//
//  Results.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import Foundation

import Foundation
import RealmSwift

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
