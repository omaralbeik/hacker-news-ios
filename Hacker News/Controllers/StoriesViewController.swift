//
//  StoriesViewController.swift
//  Hacker News
//
//  Created by Omar Albeik on 5/23/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import UIKit
import HNClient
import SnapKit
import SwifterSwift

class StoriesViewController: UIViewController {
	
	let cachSize = 10
	var currentIndex = 0
	var ids: [Int] = []
	var isRefilling = false
	
	var stories: [HNItem] = []
	
	let tableView: UITableView = {
		let view = UITableView()
		return view
	}()
	
	var loadingIndicator: StoriesTableViewLoadingView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
		setupNavigationItem()
		
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.register(cellWithClass: StoryTableViewCell.self)
		
		HNManager.shared.fetchNewStoriesIds { ids, error in
			self.ids = ids
			self.fetchNext10Posts()
		}
		
	}
	
}

extension StoriesViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return stories.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withClass: StoryTableViewCell.self)!
		cell.configure(for: stories[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		
		guard let last = tableView.indexPathForLastRow else {
			return
		}
		if (last.row - indexPath.row) < 5 && !isRefilling {
			isRefilling = true
			self.loadingIndicator?.isLoading = true
			self.fetchNext10Posts()
		}
	}
	
}


extension StoriesViewController {
	
	func fetchNext10Posts() {
		
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
					self.loadingIndicator?.isLoading = false
					self.tableView.reloadData()
					return
				}
			}
		}
	}
	
}


extension StoriesViewController {
	
	func setupViews() {
		view.addSubview(tableView)
		
		let frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 60.0)
		loadingIndicator = StoriesTableViewLoadingView(frame: frame)
		
		layoutViews()
		
		tableView.tableFooterView = loadingIndicator
		tableView.estimatedRowHeight = 80.0
		tableView.height = UITableViewAutomaticDimension
		
	}
	
	func layoutViews() {
		tableView.snp.makeConstraints { make in
			make.edges.equalTo(view)
		}
	}
	
	func setupNavigationItem() {
		title = "Hacker News"
		navigationBar?.setColors(background: AppColors.orange, text: AppColors.white)
	}
	
}
