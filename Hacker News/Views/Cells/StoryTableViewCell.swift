//
//  StoryTableViewCell.swift
//  Hacker News
//
//  Created by Omar Albeik on 5/23/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import UIKit
import HNClient
import SnapKit

class StoryTableViewCell: UITableViewCell {
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = AppColors.black
		label.font = UIFont.systemFont(ofSize: 16.0)
		label.numberOfLines = 3
		return label
	}()
	
	let scoreLabel: UILabel = {
		let label = UILabel()
		label.textColor = AppColors.orange
		label.font = UIFont.boldSystemFont(ofSize: 16.0)
		label.textColor = .red
		label.numberOfLines = 1
		label.textAlignment = .center
		return label
	}()
	
	let timeLabel: UILabel = {
		let label = UILabel()
		label.textColor = AppColors.gray
		label.font = UIFont.systemFont(ofSize: 14.0)
		label.textColor = .gray
		label.numberOfLines = 1
		return label
	}()
	
	let authorLabel: UILabel = {
		let label = UILabel()
		label.textColor = AppColors.gray
		label.font = UIFont.systemFont(ofSize: 14.0)
		label.textColor = .gray
		label.numberOfLines = 1
		return label
	}()
	
	let linkLabel: UILabel = {
		let label = UILabel()
		label.textColor = UIColor.lightGray
		label.font = UIFont.systemFont(ofSize: 12.0)
		label.textColor = .gray
		label.numberOfLines = 1
		return label
	}()
	
	let storyStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.alignment = .leading
		stackView.spacing = 4.0
		return stackView
	}()
	
	let infoStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fill
		stackView.alignment = .leading
		stackView.spacing = 8.0
		return stackView
	}()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupViews()
	}
	
}


extension StoryTableViewCell {
	
	func configure(for story: HNItem?) {
		titleLabel.text = story?.title
		if let author = story?.author {
			authorLabel.text = "by \(author)"
		}
		timeLabel.text = story?.time?.agoString
		scoreLabel.text = story?.score?.string
		
		guard let url = story?.url else {
			selectionStyle = .none
			return
		}
		selectionStyle = .default
		linkLabel.text = "(\(url.host!))"
	}
	
}


extension StoryTableViewCell {
	
	func setupViews() {
		backgroundColor = AppColors.cream
		addSubview(scoreLabel)
		
		infoStackView.addArrangedSubview(authorLabel)
		infoStackView.addArrangedSubview(timeLabel)
		
		storyStackView.addArrangedSubview(titleLabel)
		storyStackView.addArrangedSubview(linkLabel)
		storyStackView.addArrangedSubview(infoStackView)
		addSubview(storyStackView)
		
		layoutViews()
	}
	
	func layoutViews() {
		
		scoreLabel.snp.makeConstraints { make in
			make.left.equalTo(self)
			make.top.equalTo(self)
			make.bottom.equalTo(self)
			make.right.equalTo(storyStackView.snp.left)
			make.width.equalTo(50.0)
		}
		
		storyStackView.snp.makeConstraints { make in
			make.top.equalTo(self).inset(8.0)
			make.bottom.equalTo(self).inset(8.0)
			make.right.equalTo(self).inset(12.0)
		}
		
	}
	
}
