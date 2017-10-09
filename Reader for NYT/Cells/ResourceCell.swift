//
//  ResourceCell.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/7/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import UIKit

struct ResourceCellContentLine {
	let source: String
	let attributes: [NSAttributedStringKey : Any]
	let transformer: ((String) -> String)?
}

class ResourceCell : UITableViewCell {
	
	static let mutedColor = UIColor(rgb: 0x999999)
	static let selectedColor = UIColor(rgb: 0xe9ebe4)
	
	weak var tableViewController: ResourceTableViewController?
	
	static let spacedParagraphStyle: NSParagraphStyle = {
		let style = NSMutableParagraphStyle()
		style.paragraphSpacing = UIFont.systemFont(forTextStyle: .body, weight: .regular).lineHeight * 0.33
		return style
	}()
	
	func update(withResource resource: [String:Any]) {
		
	}
	
	static func text(forLines lines: [ResourceCellContentLine], withResource resource: [String:Any]) -> NSAttributedString {
		let text = NSMutableAttributedString()
		
		for (number, line) in lines.enumerated() {
			let data = (resource[line.source] as? String) ?? ""
			var transformedData = data
			if let transformer = line.transformer {
				transformedData = transformer(data)
			}
			
			transformedData = (number != 0 ? "\r\n" : "") + transformedData
			
			text.append(NSAttributedString(string: transformedData, attributes: line.attributes))
		}
		
		return text
	}
	
}
