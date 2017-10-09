//
//  StoryCell.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/7/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import UIKit
import TimeAgoInWords

class StoryCell : ResourceCell {
	@IBOutlet weak var content: UITextView!
	@IBOutlet weak var thumbnail: RemoteImageView!
	
	private static let lines = [
		ResourceCellContentLine(source: "section",
		            attributes: [.font: UIFont.systemFont(forTextStyle: .footnote, weight: .heavy),
		                         .foregroundColor: ResourceCell.mutedColor],
		            transformer: { text in
						return text.uppercased()
		}),
		
		ResourceCellContentLine(source: "title",
		            attributes: [.font: UIFont.systemFont(forTextStyle: .title1, weight: .bold),
		                         .paragraphStyle: ResourceCell.spacedParagraphStyle],
		            transformer: nil),
		
		ResourceCellContentLine(source: "abstract",
		            attributes: [.font: UIFont.preferredFont(forTextStyle: .body),
		                         .paragraphStyle: ResourceCell.spacedParagraphStyle],
		            transformer: nil),
		
		ResourceCellContentLine(source: "published_date",
		            attributes: [.font: UIFont.systemFont(forTextStyle: .body, weight: .medium),
		                         .foregroundColor: ResourceCell.mutedColor],
		            transformer: { text in
						return Api.dateFormatter.date(from: text)?.timeAgoInWords() ?? String()
		})
	]
		
	override func awakeFromNib() {
		super.awakeFromNib()
		
		selectedBackgroundView = UIView()
		selectedBackgroundView?.backgroundColor = ResourceCell.selectedColor
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		content.attributedText = nil
		thumbnail.imageURL = nil
	}
	
	override func update(withResource resource: [String : Any]) {
		
		
		content.attributedText = ResourceCell.text(forLines: StoryCell.lines, withResource: resource)
		
		if let thumbnailLink = (resource["multimedia"] as? [[String:Any]])?
			.first(where: { $0["format"] as? String == "thumbLarge" })?["url"] as? String {
			thumbnail.imageURL = URL(string: thumbnailLink)
		}
	}
}
