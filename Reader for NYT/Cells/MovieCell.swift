//
//  MovieCell.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/7/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import UIKit

class MovieCell : ResourceCell {
	@IBOutlet weak var thumbnail: RemoteImageView!
	
	@IBOutlet weak var content: UITextView!
	
	@IBOutlet weak var titleContent: UITextView!
	
	private static let dateDisplayFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .none
		return dateFormatter
	}()
	
	static let dateParseFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		return dateFormatter
	}()
	
	private static let lines = [
		ResourceCellContentLine(source: "headline",
		                        attributes: [.font: UIFont.systemFont(forTextStyle: UIFontTextStyle.title2, weight: .medium),
		                                     .paragraphStyle: ResourceCell.spacedParagraphStyle],
		                        transformer: nil),
		
		ResourceCellContentLine(source: "summary_short",
		                        attributes: [.font: UIFont.preferredFont(forTextStyle: .body),
		                                     .paragraphStyle: ResourceCell.spacedParagraphStyle],
		                        transformer: nil)
	]
	
	private static let titleLines = [
		ResourceCellContentLine(source: "display_title",
		                        attributes: [.font: UIFont.systemFont(forTextStyle: .body, weight: .bold),
		                                     .foregroundColor: UIColor.white,
		                                     .paragraphStyle: ResourceCell.spacedParagraphStyle],
		                        transformer: nil),
		
		ResourceCellContentLine(source: "opening_date",
		                        attributes: [.font: UIFont.systemFont(forTextStyle: UIFontTextStyle.footnote, weight: .medium),
		                                     .foregroundColor: UIColor.white,
		                                     .paragraphStyle: ResourceCell.spacedParagraphStyle],
		                        transformer: { text in
									if let date = MovieCell.dateParseFormatter.date(from: text),
										let formatted = MovieCell.dateDisplayFormatter.string(for: date) {
										return formatted
									}
									return NSLocalizedString("TBD", comment: "")
		}),
		
		ResourceCellContentLine(source: "mpaa_rating",
		                        attributes: [.font: UIFont.preferredFont(forTextStyle: .footnote),
		                                     .foregroundColor: ResourceCell.mutedColor],
		                        transformer: { text in
									return text.count == 0 ? NSLocalizedString("Not Rated", comment: "").uppercased() : text
		})
	]
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		titleContent.backgroundColor = .black
		
		selectedBackgroundView = UIView()
		selectedBackgroundView?.backgroundColor = ResourceCell.selectedColor
	}
	
	override func layoutSubviews() {
		let padding: CGFloat = 10.0
		titleContent.textContainerInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		
		super.layoutSubviews()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		content.attributedText = nil
		titleContent.attributedText = nil
		thumbnail.imageURL = nil
	}
	
	override func update(withResource resource: [String : Any]) {
		content.attributedText = ResourceCell.text(forLines: MovieCell.lines, withResource: resource)
		titleContent.attributedText = ResourceCell.text(forLines: MovieCell.titleLines, withResource: resource)
		
		if let thumbnailLink = (resource["multimedia"] as? [String:Any])?["src"] as? String {
			thumbnail.imageURL = URL(string: thumbnailLink)
		}
		
	}
	
	override func setHighlighted(_ highlighted: Bool, animated: Bool) {
		let viewBackColor = titleContent.backgroundColor
		super.setHighlighted(highlighted, animated: animated)
		titleContent.backgroundColor = viewBackColor
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		let viewBackColor = titleContent.backgroundColor
		super.setSelected(selected, animated: animated)
		titleContent.backgroundColor = viewBackColor
	}
}

