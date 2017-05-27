//
//  HNWebView.swift
//  Hacker News
//
//  Created by Omar Albeik on 5/27/17.
//  Copyright © 2017 Hacker News. All rights reserved.
//

import UIKit
import HNClient

class HNWebView: UIWebView {
	
	var story: HNItem? {
		didSet {
			guard let url = story?.url else {
				return
			}
			let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10.0)
			loadRequest(request)
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupView()
	}
	
	
}


extension HNWebView {
	
	func setupView() {
		backgroundColor = HNColor.cream
		tintColor = HNColor.orange
	}
	
}
