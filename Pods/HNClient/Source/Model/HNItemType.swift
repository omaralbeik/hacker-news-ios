//
//  HNItemType.swift
//  HackerNews
//
//  Created by Omar Albeik on 5/22/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import Foundation

/// Type of HNItem.
///
/// - story: Story HN
/// - ask: Ask HN
/// - poll: Poll HN
/// - job: Job HN
/// - comment: Comment HN
/// - pollOpt: Poll Opt
public enum HNItemType: String {
	case story   = "story"
	case ask     =  "ask"
	case poll    = "poll"
	case job     = "job"
	case comment = "comment"
	case pollOpt = "pollopt"
}
