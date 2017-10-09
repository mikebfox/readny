//
//  ResourceTableViewController.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/7/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import UIKit
import Siesta
import SafariServices

class ResourceTableViewController : TitledTableViewController, ResourceObserver {
	
	let statusOverlay = ResourceStatusOverlay()
	
	private var resources: [[String:Any]]?
	
	var resource: Resource? {
		willSet {
			resource?.removeObservers(ownedBy: self)
		}
		didSet {
			resource?.addObserver(self).addObserver(statusOverlay)
			resource?.loadIfNeeded()
		}
	}
	var cellIdentifier: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		statusOverlay.embed(in: self)
		
		refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: UIControlEvents.valueChanged)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		statusOverlay.positionToCoverParent()
	}
	
	func resources(forResource resource: Resource) -> [[String:Any]] {
		return resource.jsonDict["results"] as! [[String:Any]]
	}
	
	func updateCell(_ cell: UITableViewCell, withResource resource: [String:Any]) {
		guard let resourceCell = cell as? ResourceCell else { return }
		resourceCell.tableViewController = self
		resourceCell.update(withResource: resource)
	}
	
	func resourceChanged(_ resource: Resource, event: ResourceEvent) {
		resources = resources(forResource: resource)
		
		tableView.reloadData()
		
		if refreshControl != nil && refreshControl!.isRefreshing {
			refreshControl!.endRefreshing()
		}
	}
	
	func resource(forIndexPath indexPath: IndexPath) -> [String:Any]? {
		return resources?[indexPath.row]
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return resources?.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!)!
		
		if let resource = resource(forIndexPath: indexPath) {
			updateCell(cell, withResource: resource)
		}
		
		return cell
	}
	
	@objc func refresh(_ sender: Any) {
		resource?.load()
	}
}

