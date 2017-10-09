//
//  Api.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/7/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import Foundation
import Siesta

class Api : Service {
	
	static let shared = Api()
	
	static let keyName = "api-key"
	static let key = "YOUR_API_CODE_FROM_NYT"
	
	static let categories = [
		"home",
		"opinion",
		"world",
		"national",
		"politics",
		"upshot",
		"nyregion",
		"business",
		"technology",
		"science",
		"health",
		"sports",
		"arts",
		"books",
		"movies",
		"theater",
		"sundayreview",
		"fashion",
		"tmagazine",
		"food",
		"travel",
		"magazine",
		"realestate",
		"automobiles",
		"obituaries",
		"insider"
	]
	
	init() {
		super.init(baseURL: "https://api.nytimes.com/svc")
	}
	
	static let dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
		return dateFormatter
	}()
	
}
