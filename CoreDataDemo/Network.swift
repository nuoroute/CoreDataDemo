//
//  Network.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/10/17.
//  Copyright © 2017 New Route. All rights reserved.
//

import Foundation

struct Network {
    private static let apiURL = URL(string: "https://api.worldoftanks.com/wot/encyclopedia/tanks/?application_id=demo")!

    static func getJSON(completion: @escaping ([String:JSONItem]) -> ()) {
        let session = URLSession.shared.dataTask(with: apiURL) { (data, _, error) in
            guard let data = data else {
                print("getJSON(_): No data has been received")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSONItem else {
                    print("getJSON(_): Couldn't convert data to JSONItem (aka [String:Any])")
                    return
                }
                
                guard let result = self.collectData(from: json) else {
                    print("getJSON(_): Couldn't collect data")
                    return
                }
                
                completion(result)
            } catch {
                print("getJSON(_): \(error)")
            }
        }
        
        session.resume()
    }
    
    private static func collectData(from json: JSONItem) -> [String:JSONItem]? {
        var result = [String:JSONItem]()
        
        guard let tanks = json["data"]! as? JSONItem else {
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
