//
//  Storage.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/11/17.
//  Copyright © 2017 New Route. All rights reserved.
//

import Foundation

protocol Storage {
    func save(_ tank: Tank)
    var tanks: [Tank] { get }
}

class InMemoryStorage: Storage {
    private (set) var tanks = [Tank]()
    
    func save(_ tank: Tank) {
        self.tanks.append(tank)
    }
}

//class CoreDataStorage: Storage {
//    func save(_ tank: Tank) {
//        // self.tanks.append(tank)
//    }
//    
//    func getAllTanks() -> [Tank] {
//        return []
//    }
//}
