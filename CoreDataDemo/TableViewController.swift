//
//  TableViewController.swift
//  CoreDataDemo
//
//  Created by Constantine Shatalov on 7/16/17.
//  Copyright © 2017 New Route. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let storage: Storage = InMemoryStorage()
    var refresh: UIRefreshControl!
    var deleteItemIndexPath: IndexPath? = nil
    var downloadManager: DownloadManager? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString()
        refresh.addTarget(self, action: #selector(TableViewController.loadData), for: .valueChanged)
        self.tableView.addSubview(refresh)
        
        loadData()
    }
    
    func loadData() {
        downloadManager = DownloadManager(storage)
        self.storage.clear()
        
        downloadManager!.getAllTanks {
            self.tableView.reloadData()
            self.refresh.endRefreshing()
            
            self.downloadManager = nil
        }
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new item", message: "Enter tank name", preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Name"
        }
        
        alert.addAction(
            UIAlertAction(
                title: "Add", style: .default, handler: { (action: UIAlertAction) in
                    let textField = alert.textFields!.first!
                    
                    if textField.text != "" {
                        self.storage.addTank(
                            name: textField.text!,
                            nation: "",
                            type: "",
                            level: 0,
                            id: 0,
                            isPremium: false,
                            image: "",
                            smallImage: ""
                        )
                        
                        self.tableView.reloadData()
                    }
                }
            )
        )
        
        alert.addAction(
            UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        )
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Setting up Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.tanks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if storage.tanks.count == 0 {
            return cell
        }
        
        let tank = storage.tanks[indexPath.row]
        let name = tank.name
        let type = tank.type
        
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = type

        return cell
    }

    // MARK: - Deletion
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteItemIndexPath = indexPath
            let itemToDelete = storage.tanks[indexPath.row]
            confirmDeletion(itemToDelete)
        }
    }
    
    func confirmDeletion(_ item: Tank) {
        let alert = UIAlertController(
            title: "Delete Item", message: "Are you sure you want to delete this item?", preferredStyle: .actionSheet
        )
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: itemDeletion)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeletion)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func itemDeletion(alertAction: UIAlertAction!) {
        if let indexPath = deleteItemIndexPath {
            tableView.beginUpdates()
            
            storage.deleteTank(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            deleteItemIndexPath = nil
            
            tableView.endUpdates()
            
        }
    }
    
    func cancelDeletion(alertAction: UIAlertAction!) {
        deleteItemIndexPath = nil
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let itemViewController = storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as? ItemViewController {
            itemViewController.selectedItem = storage.tanks[indexPath.row]
            navigationController?.pushViewController(itemViewController, animated: true)
        }
    }
    
}
