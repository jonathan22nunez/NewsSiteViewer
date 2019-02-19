//
//  ATVC_Extension.swift
//  NunezJonathan_CE06
//
//  Created by Jonathan Nunez on 12/1/18.
//  Copyright © 2018 Jonathan Nunez. All rights reserved.
//

import Foundation

extension ArticlesTableViewController {
    func ParseJSONAtURL(url: String, source: String, key: String) {
    
            let urlWithHeader = url + "source=" + source + "&apiKey=" + key
            // Create default URLSession configuration
            let config = URLSessionConfiguration.default
    
            // Create URLSession
            let session = URLSession(configuration: config)
    
            if let url = URL(string: urlWithHeader) {
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
                            guard let articles = jsonObject["articles"] as? [Any] else{return}
    
                            for secondLevelItem in articles {
                                guard let object = secondLevelItem as? [String: Any] else{continue}
    
                                self.articlesOfSource.append(Article(jsonObject: object))
                            }
                        }
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                    // Reload TableView
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                // Resume task
                task.resume()
            }
        }
}
