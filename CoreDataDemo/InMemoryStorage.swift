//
//  InMemoryStorage.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/12/17.
//  Copyright © 2017 New Route. All rights reserved.
//

import Foundation

class InMemoryStorage: Storage {
    private (set) var tanks = [Tank]()
    
    func save(_ tank: Tank) {
        self.tanks.append(tank)
    }
}
