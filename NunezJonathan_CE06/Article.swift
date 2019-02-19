//
//  Article.swift
//  NunezJonathan_CE06
//
//  Created by Jonathan Nunez on 12/1/18.
//  Copyright © 2018 Jonathan Nunez. All rights reserved.
//

import Foundation
import UIKit

class Article {
    // Stored properties
    let author: String
    let title: String
    let description: String
    let urlToArticle: String
    var imageURL: String!
    
    // Initializer
    init(author: String, title: String, description: String, urlToArticle: String, imageURL: String) {
        self.author = author
        self.title = title
        self.description = description
        self.urlToArticle = urlToArticle
        self.imageURL = imageURL
    }
    
    // Convenience Initializer
    convenience init(jsonObject: [String: Any]) {
        // Test if JSON has valid object values, initialize default otherwise
        var author = "No author available", title = "No Title Available", description = "No Description Available", urlToArticle = "", imageURL = ""
        if let articleAuthor = jsonObject["author"] as? String {
            author = articleAuthor
        }
        if let articleTitle = jsonObject["title"] as? String {
             title = articleTitle
        }
        if let articleDescription = jsonObject["description"] as? String {
            description = "\t" + articleDescription
        }
        if let articleURL = jsonObject["url"] as? String {
            urlToArticle = articleURL
        }
        if let imageHasURL = jsonObject["urlToImage"] as? String{
            imageURL = imageHasURL
        }
        
        self.init(author: author, title: title, description: description, urlToArticle: urlToArticle, imageURL: imageURL)
    }
}
