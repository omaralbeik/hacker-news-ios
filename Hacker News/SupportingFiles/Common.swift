//
//  Common.swift
//  Hacker News
//
//  Created by Omar Albeik on 5/23/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import Foundation


extension Date {
	
	var agoString: String {
		if self.isInToday {
			return self.timeString(ofStyle: .short)
		} else if self.isInYesterday {
			return "Yesterday"
		} else if self.adding(.day, value: 7) >= Date() {
			return self.dayName(ofStyle: .full)
		} else {
			return self.dateString(ofStyle: .short)
		}
	}
	
}
