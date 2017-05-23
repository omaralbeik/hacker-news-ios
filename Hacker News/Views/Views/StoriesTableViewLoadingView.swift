//
//  StoriesTableViewLoadingView.swift
//  Hacker News
//
//  Created by Omar Albeik on 5/23/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import UIKit
import SnapKit

class StoriesTableViewLoadingView: UIView {

	let indicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
		indicator.color = AppColors.orange
		indicator.hidesWhenStopped = true
		return indicator
	}()
	
	var isLoading = false {
		didSet {
			isLoading ? indicator.startAnimating() : indicator.stopAnimating()
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupViews()
	}
	
}


extension StoriesTableViewLoadingView {
	
	func setupViews() {
		addSubview(indicator)
		layoutViews()
	}
	
	func layoutViews() {
		indicator.snp.makeConstraints { make in
			make.center.equalTo(self)
		}
	}
	
}
