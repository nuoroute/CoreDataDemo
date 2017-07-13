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

    static func getJSON(completion: @escaping ([JSONItem]) -> ()) {
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
                
                guard let tanksJSON = self.parse(json) else {
                    print("getJSON(_): Couldn't parse JSON")
                    return
                }
                
                completion(tanksJSON)
            } catch {
                print("getJSON(_): \(error)")
            }
        }
        
        session.resume()
    }
    
    private static func parse(_ json: JSONItem) -> [JSONItem]? {
        var result = [JSONItem]()
        
        guard let tanks = json["data"] as? [String:JSONItem] else {
            return nil
        }
        
        for (_, tank) in tanks {
            result.append(tank)
        }
        
        return result
    }
}
