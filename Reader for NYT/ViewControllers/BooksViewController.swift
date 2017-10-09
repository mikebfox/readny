//
//  BooksStoriesViewController.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/7/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import UIKit
import Siesta
import SafariServices

class BooksStoriesViewController : ResourceTableViewController {
	
	override func viewDidLoad() {
		cellIdentifier = "book"
		resource = Api.shared.resource("/books/v3/lists/overview.json").withParam(Api.keyName, Api.key)
		
		super.viewDidLoad()
	}
	
	override func resources(forResource resource: Resource) -> [[String:Any]] {
		guard let lists = (resource.jsonDict["results"] as? [String:Any])?["lists"] as? [[String:Any]] else { return [] }
		
		var books = lists.flatMap({ $0["books"] as! [[String:Any]] })
		
		Api.sort(&books, sortingKey: "updated_date")
		
		return books
	}
}

