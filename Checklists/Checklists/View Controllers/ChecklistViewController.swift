//
//  ViewController.swift
//  Checklists
//
//  Created by まどか on 2018-01-09.
//  Copyright © 2018 Maddy. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController,
ItemDetailViewControllerDelegate{
//    var items = [ChecklistItem]()
    var delegate: ItemDetailViewControllerDelegate?
    //set the title of the screen
    var checklist: Checklist!
    
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        let newRowIndex = checklist.items.count
        checklist.items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func ItemDetailViewController(
        _ controller: ItemDetailViewController,
        didFinishEditing item: ChecklistItem) {
        if let index = checklist.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated:true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        // 1
        if segue.identifier == "AddItem" {
            // 2
            let controller = segue.destination
                as! ItemDetailViewController
            // 3
            controller.delegate = self
        } else if segue.identifier == "EditItem"{
            let controller = segue.destination
            as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender
                as! UITableViewCell){
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //Add placeholder item data
//        for list in lists{
//            let item = ChecklistItems()
//            item.text = "Item for \(list.name))"
//            list.items.append(item)
        
//        }
        
        //Enable large titles
        navigationController?.navigationBar.prefersLargeTitles = true
        title = checklist.name
        navigationItem.largeTitleDisplayMode = .never
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return checklist.items.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
                              withIdentifier: "ChecklistItem",
                                         for: indexPath)
        
        //Add for Array
        let item = checklist.items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if let cell = tableView.cellForRow(at: indexPath){
           let item = checklist.items[indexPath.row]
           item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
}
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
          label.text = "√"
        } else {
          label.text = ""
        }
    }
    
    func configureText(for cell: UITableViewCell,
        with item: ChecklistItem) {

        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
        
    }
        
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        checklist.items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
    }
    
}

