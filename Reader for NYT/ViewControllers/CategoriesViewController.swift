//
//  CategoriesViewController.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/7/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import UIKit

class CategoriesViewController : TitledTableViewController {
	
	var currentCategory: String?
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Api.categories.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
		
		let category = Api.categories[indexPath.row]
		
		cell.textLabel?.text = category.capitalized
		cell.accessoryType = category == currentCategory ? .checkmark : .none
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		UserDefaults.standard.category = Api.categories[indexPath.row]
		
		presentingViewController?.dismiss(animated: true, completion: nil)
	}
}
