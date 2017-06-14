//
//  CommonExtensions.swift
//  Hacker News
//
//  Created by Omar Albeik on 6/14/17.
//  Copyright © 2017 Hacker News. All rights reserved.
//

import UIKit
import BusyNavigationBar


extension UINavigationBar {
	
	func setLoading(_ loading: Bool) {
		if loading {
			let options = BusyNavigationBarOptions()
			options.animationType = .stripes
			options.color = HNColor.white
			options.alpha = 1
			start(options)
		} else {
			stop()
		}
	}
	
}
