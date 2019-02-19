//
//  NewsSource.swift
//  NunezJonathan_CE06
//
//  Created by Jonathan Nunez on 12/1/18.
//  Copyright © 2018 Jonathan Nunez. All rights reserved.
//

import Foundation

class NewsSource {
    // Stored properties
    let id: String
    let name: String
    let category: String
    
    // Initializer
    init?(jsonObject: [String: Any]) {
        // Parse JSON object
        guard let id = jsonObject["id"] as? String,
            let name = jsonObject["name"] as? String,
            let category = jsonObject["category"] as? String
            else{return nil}
        
        self.id = id
        self.name = name
        self.category = category
    }
}
