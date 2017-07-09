//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/6/17.
//  Copyright © 2017 New Route. All rights reserved.
//

//  To do:
//      • getJSON(_) "returns" an empty array in case of 
//        an error. Consider returning an optional array.

import UIKit

typealias JSONItem = [String:Any]

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sourceURL = URL(string: "https://api.worldoftanks.com/wot/encyclopedia/tanks/?application_id=demo") {
            getJSON(from: sourceURL) { result in
                for item in result {
                    for (key, value) in item {
                        print("\(key): \(value)")
                    }
                    
                    print()
                }
            }
        } else {
            print("viewDidLoad(): Couldn't convert to URL")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getJSON(from url: URL, output: @escaping ([JSONItem]) -> ()) {
        var result = [JSONItem]()

        let session = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                do {
                    // Get JSON
                    let json = try JSONSerialization.jsonObject(with: data, options: [])

                    // Parse JSON
                    if let dictionary = json as? JSONItem {
                        if let data = dictionary["data"] as? JSONItem {
                            for (_, value) in data {
                                if let itemDictionary = value as? JSONItem {
                                    result.append(itemDictionary)
                                }
                            }
                        }
                    }
                } catch {
                    print("getJSON(_): \(error)")
                }
            } else {
                print("getJSON(_): No data has been received")
            }
            
            output(result)
        }
        
        session.resume()
    }
}


