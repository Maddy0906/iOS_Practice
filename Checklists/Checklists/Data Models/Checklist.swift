//
//  Checklist.swift
//  Checklists
//
//  Created by まどか on 2018-01-14.
//  Copyright © 2018 Maddy. All rights reserved.
//

import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    var items = [ChecklistItem]()
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
