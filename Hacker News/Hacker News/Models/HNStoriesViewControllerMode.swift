//
//  HNStoriesViewControllerMode.swift
//  Hacker News
//
//  Created by Omar Albeik on 5/27/17.
//  Copyright © 2017 Hacker News. All rights reserved.
//

import UIKit

enum HNStoriesViewControllerMode: String {
	case top = "Top"
	case new = "New"
	case show = "Show"
	case ask = "Ask"
	case jobs = "Jobs"
}


extension HNStoriesViewControllerMode {
	
	var icon: UIImage {
		switch self {
		case .top:
			return #imageLiteral(resourceName: "tab_bar_icon_top")
		case .new:
			return #imageLiteral(resourceName: "tab_bar_icon_new")
		case .show:
			return #imageLiteral(resourceName: "tab_bar_icon_show")
		case .ask:
			return #imageLiteral(resourceName: "tab_bar_icon_ask")
		case .jobs:
			return #imageLiteral(resourceName: "tab_bar_icon_jobs")
		}
	}
	
	var selectedIcon: UIImage {
		switch self {
		case .top:
			return #imageLiteral(resourceName: "tab_bar_icon_top_selected")
		case .new:
			return #imageLiteral(resourceName: "tab_bar_icon_new_selected")
		case .show:
			return #imageLiteral(resourceName: "tab_bar_icon_show_selected")
		case .ask:
			return #imageLiteral(resourceName: "tab_bar_icon_ask_selected")
		case .jobs:
			return #imageLiteral(resourceName: "tab_bar_icon_jobs_selected")
		}
	}
	
	var tabBarItem: UITabBarItem {
		return UITabBarItem(title: rawValue, image: icon, selectedImage: selectedIcon)
	}
	
}
