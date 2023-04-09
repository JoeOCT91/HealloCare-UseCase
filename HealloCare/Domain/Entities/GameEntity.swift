//
//  GameEntity.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var rating: Float = 0
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var metacritic: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
