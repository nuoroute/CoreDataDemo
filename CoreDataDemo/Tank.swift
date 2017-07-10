//
//  Tank.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/9/17.
//  Copyright © 2017 New Route. All rights reserved.
//

//  Info:
//  • !!! - class var allTanks: [Tank] {}
//  • id of an item should be an Int, not String
//  • getJSON(_) "returns" an empty dictionary in case
//    of an error. Consider returning an optional array.
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
    
    private static let apiURL = URL(string: "https://api.worldoftanks.com/wot/encyclopedia/tanks/?application_id=demo")!
    
    static var allTanks: [Tank] {
        var tanks = [Tank]()
        
        Tank.getJSON(from: apiURL) { result in
            for (key, _) in result {
                if let key = Int(key) {
                    tanks.append(Tank(withId: key))
                }
            }
        }
        
        return tanks
    }
    
    init(withId id: Int) {
        Tank.getJSON(from: Tank.apiURL) { result in
            if let item = result[String(id)] {
                self.nation = item["nation"] as! String
                self.name = item["name"] as! String
                self.type = item["type"] as! String
                self.level = item["level"] as! Int
                self.id = item["tank_id"] as! Int
                self.isPremium = item["is_premium"] as! Bool
                self.image = item["image"] as! String
                self.smallImage = item["image_small"] as! String
                
                print(self.name)
            } else {
                print("Item not found")
            }
        }
    }
    
    private static func getJSON(from url: URL, output: @escaping ([String:JSONItem]) -> ()) {
        let session = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print("getJSON(_): No data has been received")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSONItem else {
                    print("getJSON(_): Couldn't convert data to JSONItem (aka [String:Any])")
                    return
                }
                
                guard let result = collectData(from: json) else {
                    print("getJSON(_): Couldn't collect data")
                    return
                }
                
                output(result)
            } catch {
                print("getJSON(_): \(error)")
            }
        }
        
        session.resume()
    }
    
    private static func collectData(from json: JSONItem) -> [String:JSONItem]? {
        var result = [String:JSONItem]()
        
        guard let tanks = json["data"] as? JSONItem else {
            print("collectData(_): Couldn't convert json[\"data\"] to JSONItem")
            return nil
        }
        
        for (tankId, tankDictionary) in tanks {
            if let tankDictionary = tankDictionary as? JSONItem {
                result[tankId] = tankDictionary
            }
        }
        
        return result
    }
}
