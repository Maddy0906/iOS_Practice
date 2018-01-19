//
//  DataModel.swift
//  Checklists
//
//  Created by まどか on 2018-01-15.
//  Copyright © 2018 Maddy. All rights reserved.
//

import Foundation

class DataModel {
    var lists = [Checklist]()
    
    init() {
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
    
    //use the docuements directory
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }

//this method is now called saveChecklists()
func saveChecklists(){
    let encoder = PropertyListEncoder()
    do{
        //You encode lists insted of "items"
        let data = try encoder.encode(lists)
        try data.write(to: dataFilePath(),
                       options:  Data.WritingOptions.atomic)
    } catch {
        print("Error encoding item array!")
    }
}

//this method is now called loadChecklists()
func loadChecklists(){
    let path = dataFilePath()
    if let data = try? Data(contentsOf: path) {
        let decoder = PropertyListDecoder()
        do{
            //You decode to an object of [Checklist] type to lists
            lists = try decoder.decode([Checklist].self, from: data)
        } catch {
            print("Error decoding item array!")
        }
}
}
    
    func registerDefaults(){
        let dictionary: [String: Any] = ["ChecklistIndex": -1, "FirstTime": true]
        
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    var indexOfSelectedChecklist: Int{
        get{
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
            UserDefaults.standard.synchronize()
        }
    }
    
    func handleFirstTime(){
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        
        if firstTime {
            let checklist = Checklist(name:"List")
            lists.append(checklist)
            
            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
    }
}
