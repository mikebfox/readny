//
//  TitledTableViewController.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/7/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import UIKit


class TitledTableViewController : UITableViewController {
	static let headerFont = UIFont.systemFont(forTextStyle: UIFontTextStyle.largeTitle, weight: UIFont.Weight.black)
	static let headerPadding: CGFloat = 20.0
	
	var attributedTitle: NSAttributedString?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		attributedTitle = attributedTitle ?? NSAttributedString(string: title!)

		tableView.backgroundColor = .white
		
		tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: TitledTableViewController.headerPadding))
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return UIStatusBarStyle.lightContent
	}
	
	@objc func headerTapped(_: Any) {
		
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return String()
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return TitledTableViewController.headerFont.lineHeight + TitledTableViewController.headerPadding
	}
	
	override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		guard let header = view as? UITableViewHeaderFooterView else { return }
		header.textLabel?.textColor = .black
		header.textLabel?.font = ResourceTableViewController.headerFont
		header.textLabel?.attributedText = attributedTitle //Set it here instead of titleForHeaderInSection, becase we don't want all caps title.
		header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:))))
	}
}


