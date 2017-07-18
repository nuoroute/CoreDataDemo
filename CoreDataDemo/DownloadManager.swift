//
//  DownloadManager.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/12/17.
//  Copyright © 2017 New Route. All rights reserved.
//

import Foundation

class DownloadManager {    
    let storage: Storage!
    
    init(_ storage: Storage) {
        self.storage = storage
    }
    
    func getAllTanks(completion: @escaping () -> ()) {
        Network.getJSON() { tanksJSON in
            for tankJSON in tanksJSON {
                self.storage.addTank(from: tankJSON)
            }
        
            completion()
        }
    }
}
