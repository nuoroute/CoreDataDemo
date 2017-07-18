//
//  ItemViewController.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/17/17.
//  Copyright © 2017 New Route. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    var selectedItem: Tank? = nil
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tankNameLabel: UILabel!
    @IBOutlet weak var tankNationLabel: UILabel!
    @IBOutlet weak var tankTypeLabel: UILabel!
    @IBOutlet weak var tankLevelLabel: UILabel!
    @IBOutlet weak var tankIdLabel: UILabel!
    @IBOutlet weak var tankIsPremiumLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tank = selectedItem {
            tankNameLabel.text = "Name: \(tank.name)"
            tankNationLabel.text = "Nation: \(tank.nation)"
            tankTypeLabel.text = "Type: \(tank.type)"
            tankLevelLabel.text = "Level: \(String(tank.level))"
            tankIdLabel.text = "Id: \(String(tank.id))"
            tankIsPremiumLabel.text = tank.isPremium ? "Premium tank" : "Ordinary tank"
            
            // Get image
            DispatchQueue.global(qos: .userInitiated).async {
                let image = self.getImage()
                
                // Set image
                DispatchQueue.main.async {
                    if image != nil {
                        self.imageView.image = image
                    } else {
                        print("Could not set an image")
                    }
                }
            }
        }
    }
    
    func getImage() -> UIImage? {
        /* Unsafe change in info.plist for loading from "http://" URLs:
           Apple Transfer Security > Allow Arbitrary Loads = YES
           Default: NO
        */
        
        if let tank = selectedItem {
            if let imageURL = URL(string: tank.image) {
                do {
                    let data = try Data(contentsOf: imageURL)
                    return UIImage(data: data)
                } catch {
                    print("Could not download data")
                    return nil
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

}
