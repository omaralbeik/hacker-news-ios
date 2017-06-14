//
//  HNAlert.swift
//  Hacker News
//
//  Created by Omar Albeik on 6/14/17.
//  Copyright © 2017 Hacker News. All rights reserved.
//

import SwiftMessages


class HNAlert {
	
	var title: String?
	var body: String?
	var layout: MessageView.Layout = .StatusLine
	var theme: Theme = .warning
	
	weak private var message: MessageView!
	var config: SwiftMessages.Config!
	
	static var isShowing = false
	
	init(title: String? = nil, body: String?,
	     layout: MessageView.Layout = MessageView.Layout.MessageView,
	     theme: Theme = Theme.warning) {
		
		SwiftMessages.pauseBetweenMessages = 0
		
		self.title = title
		self.body = body
		
		let message = MessageView.viewFromNib(layout: layout)
		message.configureTheme(theme)
		message.button?.isHidden = true
		
		if title == nil {
			message.titleLabel?.isHidden = true
		}
		
		var config = SwiftMessages.Config()
		config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
		config.presentationStyle = .top
		config.dimMode = .none
		config.shouldAutorotate = true
		
		message.titleLabel?.text = title
		message.bodyLabel?.text = body
		
		self.message = message
		self.config = config
		
	}
	
	convenience init?(error: Error?, layout: MessageView.Layout = .MessageView, theme: Theme = .error) {
		guard let errorString = error?.localizedDescription else {
			return nil
		}
		self.init(body: errorString, layout: layout, theme: theme)
	}
	
	func show() {
		SwiftMessages.hideAll()
		SwiftMessages.show(config: config, view: message)
	}
	
	class func hideAll() {
		SwiftMessages.sharedInstance.hideAll()
	}
	
}


extension HNAlert {
	
	
	
	static func showURLCopied() {
		HNAlert(body: "URL Copied!", layout: .StatusLine, theme: .success).show()
	}
	
}
