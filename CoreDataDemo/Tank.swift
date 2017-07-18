//
//  Tank.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/9/17.
//  Copyright © 2017 New Route. All rights reserved.
//

import Foundation

class Tank {
    var name: String
    var nation: String
    var type: String
    var level: Int
    var id: Int
    var isPremium: Bool
    var image: String
    var smallImage: String
    
    init(from json: JSONItem) {
        self.name = json["name"] as? String ?? ""
        self.nation = json["nation"] as? String ?? ""
        self.type = json["type"] as? String ?? ""
        self.level = json["level"] as? Int ?? 0
        self.id = json["tank_id"] as? Int ?? 0
        self.isPremium = json["is_premium"] as? Bool ?? false
        self.image = json["image"] as? String ?? ""
        self.smallImage = json["image_small"] as? String ?? ""
    }
    
    init(name: String, nation: String, type: String, level: Int, id: Int, isPremium: Bool, image: String, smallImage: String) {
        self.name = name
        self.nation = nation
        self.type = type
        self.level = level
        self.id = id
        self.isPremium = isPremium
        self.image = image
        self.smallImage = smallImage
    }
}
