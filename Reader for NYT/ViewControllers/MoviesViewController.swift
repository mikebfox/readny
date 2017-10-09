//
//  MoviesViewController.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/7/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import UIKit
import Siesta
import SafariServices

class MoviesViewController : ResourceTableViewController {
	
	override func viewDidLoad() {
		cellIdentifier = "movie"
		resource = Api.shared.resource("/movies/v2/reviews/picks.json").withParam(Api.keyName, Api.key)
		
		super.viewDidLoad()
	}
	
	override func resources(forResource resource: Resource) -> [[String:Any]] {
		guard var movies = resource.jsonDict["results"] as? [[String:Any]] else { return [] }
		
		Api.sort(&movies, sortingKey: "date_updated")
		
		return movies
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		guard
			let movie = resource(forIndexPath: indexPath),
			let movieLink = (movie["link"] as? [String:Any])?["url"] as? String,
			let movieURL = URL(string: movieLink)
			else { return }
		
		present(SFSafariViewController.configuredController(withURL: movieURL), animated: true, completion: nil)
	}
}


