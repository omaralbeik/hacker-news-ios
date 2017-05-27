//
//  HNStoriesTableViewLoadingView.swift
//  Hacker News
//
//  Created by Omar Albeik on 5/27/17.
//  Copyright © 2017 Hacker News. All rights reserved.
//

import UIKit
import SnapKit


class HNStoriesTableViewLoadingView: UIView {

	fileprivate let indicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
		indicator.color = HNColor.orange
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


fileprivate extension HNStoriesTableViewLoadingView {
	
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
