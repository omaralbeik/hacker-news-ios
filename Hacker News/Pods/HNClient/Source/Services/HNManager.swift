//
//  HNManager.swift
//  HackerNews
//
//  Created by Omar Albeik on 5/22/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper


public class HNManager {

	/// Shared instance of HNManager
	public static let shared: HNManager = {
		return HNManager()
	}()

	/// Fetch a story, comment, job, Ask HN, poll or poll part for a given id
	///
	/// - Parameters:
	///   - id: item id.
	///   - completion: an optional HNItem object with an optional error.
	public func fetchItem(id: Int, _ completion: @escaping (_ item: HNItem?, _ error: Error?) -> Void) {
		Alamofire.request(itemURL(id: id).prettified).responseObject { (response: DataResponse<HNItem>) in
			completion(response.result.value, response.error)
		}
	}

	/// Fetch user profile and public activity for a given id
	///
	/// - Parameters:
	///   - id: user id
	///   - completion: HNUser object with an optional error
	public func fetchUser(id: String, _ completion: @escaping (_ user: HNUser?, _ error: Error?) -> Void) {
		Alamofire.request(userURL(id: id).prettified).responseObject { (response: DataResponse<HNUser>) in
			completion(response.result.value, response.error)
		}
	}

	/// Fetch max item ID
	///
	/// - Parameter completion: the current largest item id with an optional error
	public func fetchMaxItemId(_ completion: @escaping (_ id: Int?, _ error: Error?) -> Void) {
		Alamofire.request(maxItemIdURL.prettified).responseJSON { response in
			completion(response.value as? Int, response.error)
		}
	}

	/// Fetch top stories
	///
	/// - Parameter completion: an array of up to 500 top stories ids with an optional error
	public func fetchTopStoriesIds(_ completion: @escaping (_ ids: [Int], _ error: Error?) -> Void) {
		Alamofire.request(topStoriesURL.prettified).responseJSON { response in
			completion((response.value as? [Int]) ?? [], response.error)
		}
	}

	/// Fetch new stories
	///
	/// - Parameter completion: an array of up to 500 new stories ids with an optional error
	public func fetchNewStoriesIds(_ completion: @escaping (_ ids: [Int], _ error: Error?) -> Void) {
		Alamofire.request(newStoriesURL.prettified).responseJSON { response in
			completion((response.value as? [Int]) ?? [], response.error)
		}
	}

	/// Fetch best stories
	///
	/// - Parameter completion: an array of up to 500 best stories ids with an optional error
	public func fetchBestStoriesIds(_ completion: @escaping (_ ids: [Int], _ error: Error?) -> Void) {
		Alamofire.request(bestStoriesURL.prettified).responseJSON { response in
			completion((response.value as? [Int]) ?? [], response.error)
		}
	}

	/// Fetch Ask stories
	///
	/// - Parameter completion: an array of up to 200 latest Ask HN ids with an optional error
	public func fetchAskIds(_ completion: @escaping (_ ids: [Int], _ error: Error?) -> Void) {
		Alamofire.request(askStoriesURL.prettified).responseJSON { response in
			completion((response.value as? [Int]) ?? [], response.error)
		}
	}

	/// Fetch Show stories
	///
	/// - Parameter completion: an array of up to 200 latest Show HN ids with an optional error
	public func fetchShowIds(_ completion: @escaping (_ ids: [Int], _ error: Error?) -> Void) {
		Alamofire.request(showStoriesURL.prettified).responseJSON { response in
			completion((response.value as? [Int]) ?? [], response.error)
		}
	}

	/// Fetch Job stories
	///
	/// - Parameter completion: an array of up to 200 latest Jobs HN ids with an optional error
	public func fetchJobsIds(_ completion: @escaping (_ ids: [Int], _ error: Error?) -> Void) {
		Alamofire.request(jobStoriesURL.prettified).responseJSON { response in
			completion((response.value as? [Int]) ?? [], response.error)
		}
	}

	/// Fetch changed items and profiles
	///
	/// - Parameter completion: arrays of changed items ids and profiles ids with an optional error
	public func fetchUpdates(_ completion: @escaping (_ storiesDds: [Int], _ userIds: [String], _ error: Error?) -> Void) {
		Alamofire.request(updatesURL.prettified).responseJSON { response in
			guard let dict = response.value as? [String: Any] else {
				completion([], [], response.error)
				return
			}
			let items = dict["items"] as? [Int] ?? []
			let profiles = dict["profiles"] as? [String] ?? []
			completion(items, profiles, response.error)
		}
	}

}

extension HNManager {

	public var baseURL: URL {
		return URL(string: "https://hacker-news.firebaseio.com/v0")!
	}


	public func itemURL(id: Int) -> URL {
		return baseURL.appendingPathComponent("item/\(id).json")
	}

	public func userURL(id: String) -> URL {
		return baseURL.appendingPathComponent("user/\(id).json")
	}

	public var maxItemIdURL: URL {
		return baseURL.appendingPathComponent("maxitem.json")
	}

	public var topStoriesURL: URL {
		return baseURL.appendingPathComponent("topstories.json")
	}

	public var newStoriesURL: URL {
		return baseURL.appendingPathComponent("newstories.json")
	}

	public var bestStoriesURL: URL {
		return baseURL.appendingPathComponent("beststories.json")
	}

	public var askStoriesURL: URL {
		return baseURL.appendingPathComponent("askstories.json")
	}

	public var showStoriesURL: URL {
		return baseURL.appendingPathComponent("showstories.json")
	}

	public var jobStoriesURL: URL {
		return baseURL.appendingPathComponent("jobstories.json")
	}

	public var updatesURL: URL {
		return baseURL.appendingPathComponent("updates.json")
	}

}


fileprivate extension URL {

	var prettified: URL {
		var comp = URLComponents(url: self, resolvingAgainstBaseURL: true)!
		comp.queryItems = [URLQueryItem(name: "print", value: "pretty")]
		return comp.url!
	}

}
