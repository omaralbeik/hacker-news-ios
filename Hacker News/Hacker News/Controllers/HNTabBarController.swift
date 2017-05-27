//
//  HNTabBarController.swift
//  Hacker News
//
//  Created by Omar Albeik on 5/27/17.
//  Copyright © 2017 Hacker News. All rights reserved.
//

import UIKit
import SwifterSwift

class HNTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

		let controllers = [
			HNNavigationController(rootViewController: HNStoriesViewController(mode: .top)),
			HNNavigationController(rootViewController: HNStoriesViewController(mode: .new)),
			HNNavigationController(rootViewController: HNStoriesViewController(mode: .show)),
			HNNavigationController(rootViewController: HNStoriesViewController(mode: .jobs)),
			HNNavigationController(rootViewController: HNStoriesViewController(mode: .ask))
		]
		
		viewControllers = controllers
		
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		setupColors()
	}

}


// MARK: - Setup
extension HNTabBarController {
	
	func setupColors() {
		tabBar.setColors(background: HNColor.black, selectedBackground: HNColor.orange, item: HNColor.gray, selectedItem: .white)
	}
	
}
