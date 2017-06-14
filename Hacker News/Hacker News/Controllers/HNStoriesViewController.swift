//
//  HNStoriesViewController.swift
//  Hacker News
//
//  Created by Omar Albeik on 5/27/17.
//  Copyright © 2017 Hacker News. All rights reserved.
//

import UIKit
import HNClient
import SwifterSwift


class HNStoriesViewController: UIViewController {

	
	var mode: HNStoriesViewControllerMode = .top
	
	let tableView: HNStoriesTableView = {
		let view = HNStoriesTableView()
		return view
	}()
	
	init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil, mode: HNStoriesViewControllerMode) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		self.mode = mode
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupViews()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		getStories()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		registerFor3DTouch()
	}

}


// MARK: - UIViewControllerPreviewingDelegate
extension HNStoriesViewController: UIViewControllerPreviewingDelegate {
	
	func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
		
		// Obtain the index path and the cell that was pressed.
		let locationInTableView = tableView.convert(location, from: view)
		
		guard let indexPath = self.tableView.indexPathForRow(at: locationInTableView) else {
			return nil
		}
		
		let story = tableView.stories[indexPath.row]
		
		guard let _ = story.url else {
			return nil
		}
		
		guard let cell = tableView.cellForRow(at: indexPath) else {
			return nil
		}
		
		let webVC = HNWebViewController()
		webVC.story = story
		webVC.hidesBottomBarWhenPushed = true
		
		webVC.preferredContentSize = CGSize(width: 0.0, height: min(700.0, SwifterSwift.screenHeight - 100.0))
		previewingContext.sourceRect = tableView.convert(cell.frame, to: tableView.superview)

		return webVC

	}
	
	func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
		show(viewControllerToCommit, sender: self)
	}
	
}


// MARK: - HNStoriesTableViewDelegate
extension HNStoriesViewController: HNStoriesTableViewDelegate {
	
	func didTapCell(forStory story: HNItem) {
		guard let _ = story.url else {
			return
		}
		let webVC = HNWebViewController()
		webVC.story = story
		webVC.hidesBottomBarWhenPushed = true
		DispatchQueue.main.async {
			self.navigationController?.pushViewController(webVC)
		}
	}
	
	func didTapOpenAction(forStory story: HNItem) {
		guard let url = story.url else {
			return
		}
		UIApplication.shared.open(url, options: [:], completionHandler: nil)
	}
	
	func didTapSaveAction(forStory story: HNItem) {
		debugPrint("Should save story")
	}
	
	func didTapCopyAction(forStory story: HNItem) {
		guard let url = story.url else {
			return
		}
		url.absoluteString.copyToPasteboard()
		HNAlert.showURLCopied()
	}
	
}


// MARK: - Helpers
extension HNStoriesViewController {
	
	func registerFor3DTouch() {
		if traitCollection.forceTouchCapability == .available {
			self.registerForPreviewing(with: self, sourceView: view)
		} else {
			debugPrint("3D Touch is not available")
		}
	}
	
	func getStories() {
		
		switch mode {
		case .top:
			HNManager.shared.fetchTopStoriesIds { ids, error in
				if let error = error {
					print(error.localizedDescription)
					return
				}
				self.tableView.ids = ids
			}
		case .show:
			HNManager.shared.fetchShowIds { ids, error in
				if let error = error {
					print(error.localizedDescription)
					return
				}
				self.tableView.ids = ids
			}
		case .new:
			HNManager.shared.fetchNewStoriesIds { ids, error in
				if let error = error {
					print(error.localizedDescription)
					return
				}
				self.tableView.ids = ids
			}
		case .jobs:
			HNManager.shared.fetchJobsIds { ids, error in
				if let error = error {
					print(error.localizedDescription)
					return
				}
				self.tableView.ids = ids
			}
		case .ask:
			HNManager.shared.fetchAskIds { ids, error in
				if let error = error {
					print(error.localizedDescription)
					return
				}
				self.tableView.ids = ids
			}
		}
		
	}
	
}


// MARK: - Setup
extension HNStoriesViewController {
	
	func setupViews() {
		view.backgroundColor = HNColor.cream
		
		tableView.hnDelegate = self
		view.addSubview(tableView)
		setupTabBarItem()
		layoutViews()
		
		navigationItem.replaceTitle(with: #imageLiteral(resourceName: "nav_bar_logo"))
		
	}
	
	func layoutViews() {
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	func setupTabBarItem() {
		tabBarItem = mode.tabBarItem
	}
	
}
