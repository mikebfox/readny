//
//  StoriesViewController.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/7/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import UIKit
import Siesta
import SafariServices

class StoriesViewController : ResourceTableViewController {
	
	private static let categoriesSegue = "categories"
	
	
	private(set) var category: String? = Api.categories.first! {
		didSet {
			resource = Api.shared.resource("/topstories/v2/\(category!).json").withParam(Api.keyName, Api.key)
			
			let title = NSMutableAttributedString()
			title.append(NSAttributedString(string: self.title!))
			title.append(NSAttributedString(string: " " + category!.capitalized, attributes: [.foregroundColor: UIColor.tint.withAlphaComponent(0.3), .underlineStyle: 1]))
			
			attributedTitle = title
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		cellIdentifier = "story"
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		category = UserDefaults.standard.category ?? Api.categories.first!
	}
	
	override func resources(forResource resource: Resource) -> [[String:Any]] {
		guard var stories = resource.jsonDict["results"] as? [[String:Any]] else { return [] }
		
		Api.sort(&stories, sortingKey: "published_date")
		
		return stories
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard
			let article = resource(forIndexPath: indexPath),
			let articleLink = article["url"] as? String,
			let articleURL = URL(string: articleLink)
			else { return }
		
		present(SFSafariViewController.configuredController(withURL: articleURL), animated: true, completion: nil)
	}
	
	override func headerTapped(_: Any) {
		performSegue(withIdentifier: StoriesViewController.categoriesSegue, sender: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == StoriesViewController.categoriesSegue {
			(segue.destination as? CategoriesViewController)?.currentCategory = category
		}
	}
}
