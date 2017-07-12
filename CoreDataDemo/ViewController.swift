//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/6/17.
//  Copyright © 2017 New Route. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let storage: Storage = InMemoryStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let downloadManager = DownloadManager(storage)
        
        downloadManager.getAllTanks {
            // 
        }
        
//        _ = Tank(withId: 1) { tank in
//            Storage.save(tank)
//        }
        
//        Tank.getAllTanks() { tanks in
//            for tank in tanks {
//                Storage.save(tank)
//            }
//            
//            for tank in Storage.getAllTanks() {
//                print(tank.name)
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
