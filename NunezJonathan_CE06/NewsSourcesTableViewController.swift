//
//  NewsSourcesTableViewController.swift
//  NunezJonathan_CE06
//
//  Created by Jonathan Nunez on 12/1/18.
//  Copyright © 2018 Jonathan Nunez. All rights reserved.
//

import UIKit

class NewsSourcesTableViewController: UITableViewController {
    
    // MARK: Preparations
    @IBOutlet var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let newsAPISources = "https://newsapi.org/v1/sources"
    
    var newsSourcesList = [NewsSource]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide navigation bar for better handling of the loading screen
        self.navigationController?.isNavigationBarHidden = true
        // Show loading screen
        displayLoadingScreen()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Set number of sections to 1
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Set number of rows to that of all available news sources
        return newsSourcesList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? NewsSourceTableViewCell
            else{return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)}
        
        // Configure the cell...
        // Set cell Source title and category
        cell.newsSourceLabel.text = newsSourcesList[indexPath.row].name
        cell.categoryLabel.text = "Category: " + newsSourcesList[indexPath.row].category.capitalized

        return cell
    }
    
    // MARK: Actions
    // Display Loading Screen
    func displayLoadingScreen() {
        // Set dimensions of loading screen to match view
        loadingView.bounds.size.width = view.bounds.width
        loadingView.bounds.size.height = view.bounds.height
        loadingView.center = view.center
        // Begin activity indicator animation
        activityIndicator.startAnimating()
        // Add activity indicator to loading view subview
        loadingView.addSubview(activityIndicator)
        // Ad loading view to tableview subview
        tableView.addSubview(loadingView)
        
        // Pass Source API URL as Parsing param
        ParseJSONAtURL(url: newsAPISources)
    }
    
    // Hide Loading Screen
    func hideLoadingScreen() {
        // Stop activity indicator animation and hide
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        // Animate the loading view out of view
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.transform = CGAffineTransform(translationX: 0, y: -800)
            })
        // Bring back the navigation bar by unhidding
        self.navigationController?.isNavigationBarHidden = false
        // Set the tableview separator line to singleLine
        tableView.separatorStyle = .singleLine
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let newsSourceToSend = newsSourcesList[indexPath.row]
            
            if let destination = segue.destination as? ArticlesTableViewController {
                destination.newsSource = newsSourceToSend
            }
        }
    }

}
