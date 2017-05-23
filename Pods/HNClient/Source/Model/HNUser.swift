//
//  HNUser.swift
//  HackerNews
//
//  Created by Omar Albeik on 5/22/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import ObjectMapper


/// Hacker News User
public class HNUser: Mappable {
	
	/// The user's unique username. Case-sensitive. Required.
	public var id: String?
	
	/// Delay in minutes between a comment's creation and its visibility to other users.
	public var delay: Int?
	
	/// Creation date of the user
	public var dateCreated: Date?
	
	/// The user's optional self-description. HTML.
	public var about: String?
	
	/// The user's karma.
	public var karma: Int?
	
	/// List of the user's stories, polls and comments.
	public var submittedStoriesIds: [Int]?
	
	required public init?(map: Map) {
	}
	
	public func mapping(map: Map) {
		about               <- map["about"]
		dateCreated         <- (map["created"], DateTransform())
		delay               <- map["delay"]
		id                  <- map["id"]
		karma               <- map["karma"]
		submittedStoriesIds <- map["submitted"]
		
	}
	
}


// MARK: - CustomStringConvertible
extension HNUser: CustomStringConvertible {
	
	public var description: String {
		return toJSONString(prettyPrint: true) ?? ""
	}
	
}


// MARK: - Equatable
extension HNUser: Equatable {
	
	public static func ==(lhs: HNUser, rhs: HNUser) -> Bool {
		return lhs.id == rhs.id
	}
	
}
