//
//  RemoteImageView.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/7/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import UIKit
import Siesta

class RemoteImageView: UIImageView {
	private static var imageCache: Service = Service()
	
	var placeholderImage: UIImage?
	
	var imageURL: URL? {
		get { return imageResource?.url }
		set { imageResource = RemoteImageView.imageCache.resource(absoluteURL: newValue) }
	}
	
	private var imageResource: Resource? {
		willSet {
			imageResource?.removeObservers(ownedBy: self)
			imageResource?.cancelLoadIfUnobserved(afterDelay: 0.05)
		}
		
		didSet {
			imageResource?.loadIfNeeded()
			imageResource?.addObserver(owner: self) { [weak self] _,_ in
				self?.image = self?.imageResource?.typedContent(
					ifNone: self?.placeholderImage)
			}
		}
	}
}
