//
//  Utils.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/7/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import UIKit
import SafariServices

extension UIFont {
	static func preferredPointSize(forTextStyle style: UIFontTextStyle) -> CGFloat {
		return UIFont.preferredFont(forTextStyle: style).pointSize
	}
	
	static func systemFont(forTextStyle style: UIFontTextStyle, weight: UIFont.Weight) -> UIFont {
		return UIFont.systemFont(ofSize: UIFont.preferredPointSize(forTextStyle: style), weight: weight)
	}
}

extension UIColor {
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red >= 0 && red <= 255)
		assert(green >= 0 && green <= 255)
		assert(blue >= 0 && blue <= 255)
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}
	
	convenience init(rgb: Int) {
		self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF)
	}
	
	static let tint: UIColor = .black
}

extension UIApplication {
	var statusBarView: UIView? {
		return value(forKey: "statusBar") as? UIView
	}
}

extension UserDefaults {
	var openInReaderMode: Bool {
		return bool(forKey: "reader_mode")
	}
	
	var category: String? {
		set {
			set(newValue, forKey: "category")
		}
		
		get {
			return value(forKey: "category") as? String
		}
	}
}

extension Api {
	private static func extractDate(fromResource resource: [String:Any], sortingKey: String) -> Date {
		guard
			let dateString = resource[sortingKey] as? String,
			let date = Api.dateFormatter.date(from: dateString)
			else { return Date() }
		return date
	}
	
	static func sort(_ resources: inout [[String:Any]], sortingKey: String) {
		resources.sort(by: {
			extractDate(fromResource:$0, sortingKey: sortingKey)
				>
				extractDate(fromResource:$1, sortingKey: sortingKey)
		})
	}
}

extension SFSafariViewController {
	static func configuredController(withURL url: URL, forceDefaultMode: Bool = false) -> SFSafariViewController{
		let configration = SFSafariViewController.Configuration()
		configration.entersReaderIfAvailable = forceDefaultMode ? false : UserDefaults.standard.openInReaderMode
		
		let viewController = SFSafariViewController(url: url, configuration: configration)
		viewController.preferredBarTintColor = .tint
		
		return viewController
	}
}
