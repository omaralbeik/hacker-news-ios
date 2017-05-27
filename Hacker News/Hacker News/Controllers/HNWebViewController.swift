//
//  HNWebViewController.swift
//  Hacker News
//
//  Created by Omar Albeik on 5/27/17.
//  Copyright © 2017 Hacker News. All rights reserved.
//

import UIKit
import HNClient
import SwifterSwift

class HNWebViewController: UIViewController {

	var story: HNItem?
	
	let webView: HNWebView = {
		let view = HNWebView()
		return view
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupNavigationItem()
		setupViews()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		webView.story = story
	}

}


extension HNWebViewController {
	
	func didTapShareButton() {
		
		guard let url = self.story?.url else {
			return
		}
		
		let alert = UIAlertController(title: "Share Story", message: nil, preferredStyle: .actionSheet)
		
		alert.addAction(title: "Open in browser") { _ in
			UIApplication.shared.open(url, options: [:], completionHandler: nil)
		}
		
		alert.addAction(title: "Copy URL") { _ in
			url.absoluteString.copyToPasteboard()
		}
		
		alert.addAction(title: "Cancel")
		
		alert.view.tintColor = HNColor.orange
		alert.show()
	}
	
}


extension HNWebViewController {
	
	func setupViews() {
		view.backgroundColor = HNColor.cream
		view.addSubview(webView)
		
		layoutViews()
	}
	
	func layoutViews() {
		webView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	func setupNavigationItem() {
		let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShareButton))
		navigationItem.rightBarButtonItem = shareButton
	}
	
}
