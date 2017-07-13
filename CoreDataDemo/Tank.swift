//
//  Tank.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/9/17.
//  Copyright © 2017 New Route. All rights reserved.
//

//  Info:
//  • Make init failable (in case item not found)
//  • Force unwrapping in init may be a bad idea
//  • Images should probably be UIImage's

import Foundation

class Tank {
    var nation = ""
    var name = ""
    var type = ""
    var level = 0
    var id = 0
    var isPremium = false
    var image = ""
    var smallImage = ""
    
    static func getAllTanks(completion: @escaping ([Int:Tank]) -> ()) {
        var tanks = [Int:Tank]()
        
        Network.getJSON() { json in
            for (_, tank) in json {
                let id = tank["tank_id"] as! Int
                let tank = Tank(
                    nation: tank["nation"] as! String,
                    name: tank["name"] as! String,
                    type: tank["type"] as! String,
                    level: tank["level"] as! Int,
                    id: tank["tank_id"] as! Int,
                    isPremium: tank["is_premium"] as! Bool,
                    image: tank["image"] as! String,
                    smallImage: tank["image_small"] as! String
                )
                
                tanks[id] = tank
            }
            
            completion(tanks)
        }
    }
    
    init(withId id: Int, completion: @escaping (Tank) -> ()) {
        Tank.getAllTanks() { tanks in
            if let tank = tanks[id] {
                self.nation = tank.nation
                self.name = tank.name
                self.type = tank.type
                self.level = tank.level
                self.id = tank.id
                self.isPremium = tank.isPremium
                self.image = tank.image
                self.smallImage = tank.smallImage
                
                completion(self)
            }
        }
    }
    
    private init(nation: String, name: String, type: String, level: Int, id: Int, isPremium: Bool, image: String, smallImage: String) {
        self.nation = nation
        self.name = name
        self.type = type
        self.level = level
        self.id = id
        self.isPremium = isPremium
        self.image = image
        self.smallImage = smallImage
    }
}
