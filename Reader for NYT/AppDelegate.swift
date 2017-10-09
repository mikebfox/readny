//
//  AppDelegate.swift
//  Reader for NYT
//
//  Created by Mikhail Bolshakov on 10/7/17.
//  Copyright © 2017 Dolphin and Mermaids. All rights reserved.
//

import UIKit
import TimeAgoInWords

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		 UserDefaults.standard.register(defaults: [String : Any]())
		
		let railsStrings = [
			"LessThan": "",
			"About": "",
			"Over": "",
			"Almost": "",
			"Seconds": "s",
			"Minute": "m",
			"Minutes": "m",
			"Hour": "h",
			"Hours": "h",
			"Day": "d",
			"Days": "d",
			"Months": "m",
			"Years": "y",
			]
		TimeAgoInWordsStrings.updateStrings(railsStrings)
		
		UIApplication.shared.statusBarView?.backgroundColor = .tint
		window?.tintColor = .tint
		
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		
	}
	
	
}

