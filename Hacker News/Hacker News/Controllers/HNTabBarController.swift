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
		delegate = self

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


// MARK: - UITabBarControllerDelegate
extension HNTabBarController: UITabBarControllerDelegate {
	
	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
		let tabViewControllers = tabBarController.viewControllers!
		guard let index = tabViewControllers.index(of: viewController) else {
			return false
		}
		animateToTab(to: index)
		return true
	}
	
	/// Animate to a tab of given index
	func animateToTab(to index: Int) {
		let tabViewControllers = viewControllers!
		let fromView = selectedViewController!.view
		let toView = tabViewControllers[index].view
		let fromIndex = tabViewControllers.index(of: selectedViewController!)
		
		guard fromIndex != index else {return}
		
		// Add the toView to the tab bar view
		fromView?.superview!.addSubview(toView!)
		
		// Position toView off screen (to the left/right of fromView)
		let screenWidth = UIScreen.main.bounds.size.width
		let scrollRight = index > fromIndex!
		let offset = (scrollRight ? screenWidth : -screenWidth)
		toView?.center = CGPoint(x: fromView!.center.x + offset, y: toView!.center.y)
		
		// Disable interaction during animation
		view.isUserInteractionEnabled = false
		
		UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
			
			// Slide the views by -offset
			fromView?.center = CGPoint(x: fromView!.center.x - offset, y: fromView!.center.y);
			toView?.center   = CGPoint(x: toView!.center.x - offset, y: toView!.center.y);
			
		}, completion: { finished in
			
			// Remove the old view from the tabbar view.
			fromView?.removeFromSuperview()
			self.selectedIndex = index
			self.view.isUserInteractionEnabled = true
		})
	}
}


// MARK: - Setup
extension HNTabBarController {
	
	func setupColors() {
		tabBar.setColors(background: HNColor.black, selectedBackground: HNColor.orange, item: HNColor.gray, selectedItem: .white)
	}
	
}
