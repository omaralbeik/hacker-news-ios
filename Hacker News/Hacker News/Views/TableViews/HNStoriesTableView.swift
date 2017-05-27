//
//  HNStoriesTableView.swift
//  Hacker News
//
//  Created by Omar Albeik on 5/27/17.
//  Copyright © 2017 Hacker News. All rights reserved.
//

import UIKit
import HNClient


protocol HNStoriesTableViewDelegate: class {
	func didTapCell(forStory story: HNItem)
	func didTapSaveAction(forStory story: HNItem)
	func didTapOpenAction(forStory story: HNItem)
}


class HNStoriesTableView: UITableView {

	weak var hnDelegate: HNStoriesTableViewDelegate?
	
	var ids: [Int] = [] {
		didSet {
			fetchNext10Stories()
		}
	}
	
	let cachSize = 10
	var stories: [HNItem] = []
	
	fileprivate var currentIndex = 0
	fileprivate var isRefilling = false
	
	var loadingIndicator: HNStoriesTableViewLoadingView?
	
	override init(frame: CGRect, style: UITableViewStyle) {
		super.init(frame: frame, style: style)
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupView()
	}

}


extension HNStoriesTableView: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return stories.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = dequeueReusableCell(withClass: HNStoryTableViewCell.self)!
		cell.configure(forStory: stories[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		guard let last = tableView.indexPathForLastRow else {
			return
		}
		
		if (last.row - indexPath.row) < 5 && !isRefilling {
			isRefilling = true
			loadingIndicator?.isLoading = true
			fetchNext10Stories()
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		hnDelegate?.didTapCell(forStory: stories[indexPath.row])
		deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		let openUrlAction = UITableViewRowAction(style: .default, title: "Open") { action, indexPath in
			self.setEditing(false, animated: true)
			self.hnDelegate?.didTapOpenAction(forStory: self.stories[indexPath.row])
		}
		openUrlAction.backgroundColor = HNColor.black
		
		return [openUrlAction]
	}
	
}


extension HNStoriesTableView {
	
	func fetchNext10Stories() {
		var fetchedCount = 0
		let max = min(currentIndex + cachSize, ids.count)
		
		for id in ids[currentIndex..<max] {
			HNManager.shared.fetchItem(id: id) { story, error in
				if let story = story {
					self.stories.append(story)
					fetchedCount += 1
					self.currentIndex += 1
				}
				if fetchedCount == self.cachSize {
					self.isRefilling = false
					self.loadingIndicator?.isLoading = true
					self.reloadData()
					return
				}
			}
		}
	}

	
}


fileprivate extension HNStoriesTableView {
	
	func setupView() {
		
		dataSource = self
		delegate = self
		register(cellWithClass: HNStoryTableViewCell.self)
		
		let frame = CGRect(x: 0, y: 0, width: bounds.width, height: 60.0)
		loadingIndicator = HNStoriesTableViewLoadingView(frame: frame)
		tableFooterView = loadingIndicator

		estimatedRowHeight = 80.0
		height = UITableViewAutomaticDimension
		
		backgroundColor = HNColor.cream
		separatorStyle = .none
		
	}
}
