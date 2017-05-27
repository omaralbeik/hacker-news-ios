//
//  HNNavigationController.swift
//  Hacker News
//
//  Created by Omar Albeik on 5/27/17.
//  Copyright © 2017 Hacker News. All rights reserved.
//

import UIKit
import SwifterSwift

class HNNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
		setupColors()
    }

}


// MARK: - Setup
extension HNNavigationController {
	
	func setupColors() {
		navigationBar.setColors(background: HNColor.orange, text: .white)
	}
	
}
