//
//  NSTVC_Extension.swift
//  NunezJonathan_CE06
//
//  Created by Jonathan Nunez on 12/1/18.
//  Copyright © 2018 Jonathan Nunez. All rights reserved.
//

import Foundation

extension NewsSourcesTableViewController {
    // Method to Parse JSON at URL
    func ParseJSONAtURL(url: String) {
        // Create default URLSession configuration
        let config = URLSessionConfiguration.default
        
        // Create URLSession
        let session = URLSession(configuration: config)
        
        if let url = URL(string: url) {
            // Create a task
            let task = session.dataTask(with: url) { (data, response, error) in
                // Test for error
                if error != nil {assertionFailure(); return}
                
                // Test HTTPReponse status
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200,
                    let data = data
                    else{assertionFailure(); return}
                
                do {
                    // De-serialize JSON from a Data buffer
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        guard let sources = jsonObject["sources"] as? [Any] else{return}
                        
                        for secondLevelItem in sources {
                            guard let object = secondLevelItem as? [String: Any] else{continue}
                            
                            self.newsSourcesList.append(NewsSource(jsonObject: object)!)
                        }
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
                
                // Reload tableview to update data
                // Hide loading view
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.hideLoadingScreen()
                }
                
            }
            // Resume task
            task.resume()
        }
    }
}
