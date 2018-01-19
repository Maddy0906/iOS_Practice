//
//  ChecklistItem.swift
//  Checklists
//
//  Created by まどか on 2018-01-11.
//  Copyright © 2018 Maddy. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}

