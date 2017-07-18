//
//  Storage.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/11/17.
//  Copyright © 2017 New Route. All rights reserved.
//

import Foundation

protocol Storage {
    var tanks: [Tank] { get }
    
    func addTank(from dictionary: JSONItem)
    func addTank(name: String, nation: String, type: String, level: Int, id: Int, isPremium: Bool, image: String, smallImage: String)
    func addTank(_ tank: Tank)
    func deleteTank(_ tank: Tank)
    func deleteTank(atIndex index: Int)
    func clear()
}
