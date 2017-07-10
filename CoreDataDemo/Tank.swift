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
//  • Images should probably be a UIImage

import Foundation

typealias JSONItem = [String:Any]

class Tank {
    var nation = ""
    var name = ""
    var type = ""
    var level = 0
    var id = 0
    var isPremium = false
    var image = ""
    var smallImage = ""
    
    static var allTanks: [Tank] {
        var tanks = [Tank]()
        Network.getJSON() { json in
            for (key, _) in json {
                if let key = Int(key) {
                    tanks.append(Tank(withId: key))
                }
            }
        }
        
        return tanks
    }
    
    init(withId id: Int) {
        Network.getJSON() { json in
            if let tank = json[String(id)] {
                self.nation = tank["nation"] as! String
                self.name = tank["name"] as! String
                self.type = tank["type"] as! String
                self.level = tank["level"] as! Int
                self.id = tank["tank_id"] as! Int
                self.isPremium = tank["is_premium"] as! Bool
                self.image = tank["image"] as! String
                self.smallImage = tank["image_small"] as! String
                
                print(self.name)
            } else {
                print("Item not found")
            }
        }
    }
}
