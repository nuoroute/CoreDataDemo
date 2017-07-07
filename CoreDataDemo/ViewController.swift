//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/6/17.
//  Copyright © 2017 New Route. All rights reserved.
//

//  • "if let" statements

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // getJSON(from: "https://jsonplaceholder.typicode.com/users")
        postJSON(["1":"Message 1", "2":"Message 2"], to: "https://jsonplaceholder.typicode.com/posts")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Get JSON from server
    func getJSON(from address: String) {
        guard let url = URL(string: address) else {
            return
        }
        
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
                    print(jsonData)
                } catch {
                    print("getJSON(..): \(error)")
                }
            } else {
                print("getJSON(..): No data")
            }
            
            if let response = response {
                print(response)
            } else {
                print("getJSON(..): No response")
            }
        }
        
        session.resume()
    }
    
    // Post JSON to server
    func postJSON(_ jsonDictionary: [String:String], to address: String) {
        guard let url = URL(string: address) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDictionary, options: []) {
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } else {
            print("getJSON(..): Couldn't convert to JSON")
        }
        
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
                    print(jsonData)
                } catch {
                    print("postJSON(..): \(error)")
                }
            } else {
                print("postJSON(..): No data")
            }
            
            if let response = response {
                print(response)
            } else {
                print("postJSON(..): No response")
            }
        }
        
        session.resume()
    }

}

