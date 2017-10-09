//
//  MainTabBarController.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/8/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController, UITabBarControllerDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		delegate = self
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return UIStatusBarStyle.lightContent
	}
	
	func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
		if let titledTableViewController = viewController as? TitledTableViewController {
			titledTableViewController.tableView.setContentOffset(CGPoint(x: 0.0, y: -titledTableViewController.tableView.tableHeaderView!.frame.height), animated: true)
		}
	}
}

