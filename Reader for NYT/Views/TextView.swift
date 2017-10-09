//
//  TextView.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/7/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import UIKit

class TextView : UITextView {
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.isEditable = false
		self.isUserInteractionEnabled = false
		self.isSelectable = false
		self.isScrollEnabled = false
		self.textContainerInset = .zero
		self.textContainer.lineFragmentPadding = 0
	}
}
