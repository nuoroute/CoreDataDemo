//
//  InMemoryStorage.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/12/17.
//  Copyright © 2017 New Route. All rights reserved.
//

//  • Implements CRUD functionality for items (update is not
//    implemented)

import Foundation

class InMemoryStorage: Storage {
    private (set) var tanks = [Tank]()
    
    func addTank(_ tank: Tank) {
        self.tanks.append(tank)
    }
    
    func addTank(from json: JSONItem) {
        self.tanks.append(Tank(from: json))
    }
    
    func addTank(name: String, nation: String, type: String, level: Int, id: Int, isPremium: Bool, image: String, smallImage: String) {
        self.tanks.append(
            Tank(
                name: name,
                nation: nation,
                type: type,
                level: level,
                id: id,
                isPremium: isPremium,
                image: image,
                smallImage: smallImage
            )
        )
    }
    
    func deleteTank(_ tank: Tank) {
        if let index = self.tanks.index(where: { $0.name == tank.name }) {
            tanks.remove(at: index)
        } else {
            print("InMemoryStorage > deleteTank(_): Tank not found")
        }
    }
    
    func deleteTank(atIndex index: Int) {
        tanks.remove(at: index)
    }
    
    func clear() {
        self.tanks.removeAll()
    }
}
