//
//  ArticleViewController.swift
//  NunezJonathan_CE06
//
//  Created by Jonathan Nunez on 12/1/18.
//  Copyright © 2018 Jonathan Nunez. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController, WKUIDelegate {
    
    // MARK: Preparations
    var webView: WKWebView!
    
    @IBOutlet weak var articleTitleLabel: UITextView!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleAuthorLabel: UILabel!
    @IBOutlet weak var articleDescription: UITextView!
    @IBOutlet weak var contineToArticleButton: UIButton!
    
    var sourceString: String!
    var article: Article!
    var urlToArticle: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Get Source title and pass to Title of ViewController
        self.title = sourceString
        
        // Set Article object values to the label/textview.text values
        articleTitleLabel.text = article.title
            // Test if Article object has a valid Image URL
        if article.imageURL.contains("http"), let imageURL = URL(string: article.imageURL) {
            do {
                // Create Data buffer from whatever is at URL
                let imageData = try Data.init(contentsOf: imageURL)
                // Convert Data to an UIImage
                articleImage.image = UIImage(data: imageData)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        articleAuthorLabel.text = article.author
        articleDescription.text = article.description
            // Test if Article object has a valid urlToArticle URL
        if article.urlToArticle.contains("http") {
            urlToArticle = article.urlToArticle
            // Reveal button to visit the article at the given URL if one exists
            contineToArticleButton.isHidden = false
        }
    }

    // MARK: Actions
    @IBAction func openArticleURL(_ sender: UIButton) {
        // Initiate a WKWebView
        // Set a WebView config
        let webConfiguration = WKWebViewConfiguration()
        // Build WKWebView with config
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        // Declare WebKit Delegate as ViewController self
        webView.uiDelegate = self
        view = webView
        
        // Gather the url string
        let url = URL(string: urlToArticle)
        // Build URL Request with URL
        let myRequest = URLRequest(url: url!)
        // Load WKWebView
        webView.load(myRequest)
    }
}
