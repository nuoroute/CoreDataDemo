//
//  DownloadManager.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/12/17.
//  Copyright © 2017 New Route. All rights reserved.
//

import Foundation

class DownloadManager {
    // Pulls each tank from json
    // Saves tanks in storage
    
    let storage: Storage!
    
    init(_ storage: Storage) {
        self.storage = storage
    }
    
    func getAllTanks(completion: () -> ()) {
        
    }
}
