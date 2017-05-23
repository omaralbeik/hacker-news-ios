//
//  HNItem.swift
//  HackerNews
//
//  Created by Omar Albeik on 5/22/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import ObjectMapper


/// Story, comment, job, Ask HN, poll or poll part
public final class HNItem: Mappable {
	
	/// Item's unique id.
	public var id: Int?
	
	/// True if the item is deleted.
	public var isDeleted: Bool?
	
	/// Type of item.
	public var type: HNItemType?
	
	/// Username of the item's author.
	public var author: String?
	
	/// Creation date of the item.
	public var time: Date?
	
	/// The comment, story or poll text. HTML.
	public var text: String?
	
	/// True if the item is dead.
	public var isDead: Bool?
	
	/// Comment's parent: either another comment or the relevant story.
	public var parentId: Int?
	
	/// Pollopt's associated poll.
	public var pollId: Int?
	
	/// IDs of the item's comments, in ranked display order.
	public var kidsIds: [Int]?
	
	/// URL of the story.
	public var url: URL?
	
	/// Story's score, or the votes for a pollopt.
	public var score: Int?
	
	/// The title of the story, poll or job.
	public var title: String?
	
	/// List of related pollopts, in display order.
	public var pollParts: [Int]?
	
	/// In the case of stories or polls, the total comment count.
	public var descendants: Int?
	
	
	required public init?(map: Map) {
	}
	
	public func mapping(map: Map) {
		id          <- map["id"]
		isDeleted   <- map["deleted"]
		type        <- (map["type"], EnumTransform())
		author      <- map["by"]
		time        <- (map["time"], DateTransform())
		text        <- map["text"]
		isDead      <- map["dead"]
		parentId    <- map["parent"]
		pollId      <- map["poll"]
		kidsIds     <- map["kids"]
		url         <- (map["url"], URLTransform())
		score       <- map["score"]
		title       <- map["title"]
		pollParts   <- map["parts"]
		descendants <- map["descendants"]
	}
	
}


// MARK: - CustomStringConvertible
extension HNItem: CustomStringConvertible {
	
	public var description: String {
		return toJSONString(prettyPrint: true) ?? ""
	}
	
}


// MARK: - Equatable
extension HNItem: Equatable {
	
	public static func ==(lhs: HNItem, rhs: HNItem) -> Bool {
		return lhs.id == rhs.id
	}
	
}
