//
//  BookCell.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/7/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import UIKit
import SafariServices

class BookCell : ResourceCell {
	@IBOutlet weak var thumbnail: RemoteImageView!
	
	@IBOutlet weak var content: UITextView!
	
	@IBOutlet weak var more: UIButton!
	
	@IBOutlet weak var view: UIButton!
	
	private var sellers: [(String, URL)] = []
	private var title: String?
		
	private static let lines = [
		ResourceCellContentLine(source: "title",
		                        attributes: [.font: UIFont.systemFont(forTextStyle: UIFontTextStyle.title1, weight: .bold)],
		                        transformer: {text -> String in
									return text.capitalized
		}),
		
		ResourceCellContentLine(source: "author",
		                        attributes: [.font: UIFont.systemFont(forTextStyle: UIFontTextStyle.title2, weight: .medium),
		                                     .foregroundColor: ResourceCell.mutedColor,
		                                     .paragraphStyle: ResourceCell.spacedParagraphStyle],
		                        transformer: nil),
		
		ResourceCellContentLine(source: "description",
		                        attributes: [.font: UIFont.preferredFont(forTextStyle: .body),
		                                     .paragraphStyle: ResourceCell.spacedParagraphStyle],
		                        transformer: nil)
	]
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		for button in [view, more] {
			button!.titleLabel?.font = UIFont.systemFont(forTextStyle: UIFontTextStyle.footnote, weight: UIFont.Weight.bold)
			
			button!.backgroundColor = UIColor.tint.withAlphaComponent(0.05)
			button!.tintColor = UIColor.tint.withAlphaComponent(0.6)
			button!.clipsToBounds = false
			button!.layer.cornerRadius = button!.frame.height / 2.0
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		content.attributedText = nil
		thumbnail.imageURL = nil
		title = nil
		view.isHidden = true
		more.isHidden = true
		sellers = []
	}
	
	override func update(withResource resource: [String : Any]) {
		content.attributedText = ResourceCell.text(forLines: BookCell.lines, withResource: resource)
		
		if let thumbnailLink = resource["book_image"] as? String {
			thumbnail.imageURL = URL(string: thumbnailLink)
		}
		
		if let title = resource["title"] as? String  {
			self.title = title
		}
		
		
		if let sellers = resource["buy_links"] as? [[String:Any]] {
			for seller in sellers {
				if let name = seller["name"] as? String,
					let link = seller["url"] as? String,
					let url = URL(string: link) {
					self.sellers.append((name, url))
				}
			}
		}
		
		view.isHidden = sellers.isEmpty
		let title = sellers.isEmpty ? String() : (NSLocalizedString("View on ", comment: "") + sellers.first!.0).uppercased()
		view.setTitle(title, for: UIControlState.normal)
		more.isHidden = sellers.count <= 1
	}
	
	@IBAction func showMore(_ sender: Any) {
		guard !sellers.isEmpty else { return }
		
		let alertController = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
		
		for (name, url) in sellers[1...] {
			alertController.addAction(UIAlertAction(title: name, style: UIAlertActionStyle.default, handler: { [weak self] (action: UIAlertAction) in
				self?.tableViewController?.present(SFSafariViewController.configuredController(withURL: url, forceDefaultMode: true), animated: true, completion: nil)
			}))
		}
		
		alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertActionStyle.cancel, handler: nil))
		
		tableViewController?.present(alertController, animated: true, completion: nil)
	}
	
	@IBAction func view(_ sender: Any) {
		guard let url = sellers.first?.1 else { return }
		tableViewController?.present(SFSafariViewController.configuredController(withURL: url, forceDefaultMode: true), animated: true, completion: nil)
	}
}
