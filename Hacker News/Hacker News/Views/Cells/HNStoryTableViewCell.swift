//
//  HNStoryTableViewCell.swift
//  Hacker News
//
//  Created by Omar Albeik on 5/27/17.
//  Copyright © 2017 Hacker News. All rights reserved.
//

import UIKit
import HNClient
import SnapKit


class HNStoryTableViewCell: UITableViewCell {

	let upvoteButton: UIButton = {
		let button = UIButton(type: .system)
		button.tintColor = .darkGray
		button.setImage(#imageLiteral(resourceName: "upvote_icon"), for: .normal)
		return button
	}()
	
	let scoreLabel: UILabel = {
		let label = UILabel()
		label.textColor = HNColor.orange
		label.font = UIFont.systemFont(ofSize: 12.0)
		label.numberOfLines = 1
		label.textAlignment = .center
		return label
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = HNColor.black
		label.font = UIFont.systemFont(ofSize: 16.0)
		label.numberOfLines = 3
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
	
	let authorLabel: UILabel = {
		let label = UILabel()
		label.textColor = HNColor.gray
		label.font = UIFont.systemFont(ofSize: 14.0)
		label.textColor = .gray
		label.numberOfLines = 1
		return label
	}()
	
	let timeLabel: UILabel = {
		let label = UILabel()
		label.textColor = HNColor.gray
		label.font = UIFont.systemFont(ofSize: 14.0)
		label.textColor = .gray
		label.numberOfLines = 1
		return label
	}()
	
	let upvoteStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.alignment = .fill
		stackView.spacing = 2.0
		return stackView
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



extension HNStoryTableViewCell {
	
	func configure(forStory story: HNItem?) {
		titleLabel.text = story?.title
		if let author = story?.author {
			authorLabel.text = "by \(author)"
		}
		timeLabel.text = story?.time?.timeString(ofStyle: .short)
		scoreLabel.text = story?.score?.string
		
		guard let url = story?.url else {
			selectionStyle = .none
			return
		}
		selectionStyle = .default
		linkLabel.text = "(\(url.host!))"
	}
	
}



extension HNStoryTableViewCell {
	
	func setupViews() {
		backgroundColor = HNColor.cream
		
		upvoteStackView.addArrangedSubview(upvoteButton)
		upvoteStackView.addArrangedSubview(scoreLabel)
		addSubview(upvoteStackView)
		
		infoStackView.addArrangedSubview(authorLabel)
		infoStackView.addArrangedSubview(timeLabel)
		
		storyStackView.addArrangedSubview(titleLabel)
		storyStackView.addArrangedSubview(linkLabel)
		storyStackView.addArrangedSubview(infoStackView)
		addSubview(storyStackView)
		
		layoutViews()
	}
	
	func layoutViews() {
		
		upvoteStackView.snp.makeConstraints { make in
			make.left.equalToSuperview()
			make.width.equalTo(45.0)
			make.centerY.equalToSuperview()
			make.right.equalTo(storyStackView.snp.left)
		}
		
		storyStackView.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(8.0)
			make.bottom.equalToSuperview().inset(8.0)
			make.right.equalToSuperview().inset(12.0)
		}
		
	}
	
}
