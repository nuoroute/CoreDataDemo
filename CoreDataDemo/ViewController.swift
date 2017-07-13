//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/6/17.
//  Copyright © 2017 New Route. All rights reserved.
//

import UIKit

typealias JSONItem = [String:Any]

class ViewController: UIViewController {
    let storage: Storage = InMemoryStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create tanks and save them in storage
        let _ = Tank(withId: 3393) { tank in
            self.storage.save(tank)
            
            print(tank.name)
            print(tank.nation)
            print(tank.id)
        }

        Tank.getAllTanks() { tanks in
            for (_, tank) in tanks {
                self.storage.save(tank)
            
                // print(tank.name)
                // print(tank.nation)
                // print(tank.id)
                // print()
            }
        }
        
//        // Retrieve tanks from that storage using download manager
//        let downloadManager = DownloadManager(storage)
//        
//        downloadManager.getAllTanks {
//            // Will return tanks once completed ??what??
//            for each in downloadManager.storage.tanks {
//                print(each.name)
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
