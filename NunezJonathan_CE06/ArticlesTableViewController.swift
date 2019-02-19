//
//  ArticlesTableViewController.swift
//  NunezJonathan_CE06
//
//  Created by Jonathan Nunez on 12/1/18.
//  Copyright © 2018 Jonathan Nunez. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController {
    
    // MARK: Preparations
    let newsAPIKey = "27aaf3b4532e410ead16b9208b4c7bdc"
    let newsAPIArticle = "https://newsapi.org/v1/articles?"
    
    var newsSource: NewsSource!
    var articlesOfSource = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Use Source object key, URL, and APIKey as params in Parsing Function
        if let source = newsSource {
            ParseJSONAtURL(url: newsAPIArticle, source: source.id, key: newsAPIKey)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Set sections to 1
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Set number of rows to that of the articlesOfSource
        return articlesOfSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Use the article title as the cell title.text
        cell.textLabel?.text = articlesOfSource[indexPath.row].title

        // Configure the cell...

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let articleToSend = articlesOfSource[indexPath.row]
            
            if let destination = segue.destination as? ArticleViewController {
                destination.sourceString = newsSource.name
                destination.article = articleToSend
            }
        }
    }
}
