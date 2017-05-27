# HNClient

Super easy to use client for Hacker News API

[![Cocoapods](https://img.shields.io/cocoapods/v/HNClient.svg)](https://cocoapods.org/pods/HNClient)
[![Platform](https://img.shields.io/cocoapods/p/HNClient.svg?style=flat)](https://github.com/omaralbeik/HNClient)
[![Swift](https://img.shields.io/badge/Swift-3.1-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-8.3-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

# Usage

Get Hacker News items, user profiles, and much more with few lines of code

## Items

Fetch a story, comment, job, Ask HN, poll or poll part for a given id:
```swift
HNManager.shared.fetchItem(id: 9127232) { item, error in
  // returns an optional HNItem object
}
```


## Users

Fetch user profile and public activity for a given id:
```swift
HNManager.shared.fetchUser(id: "jl") { user, error in
  // returns an optional HNUser object
}
```


## Live Data

Fetch max item ID:
```swift
HNManager.shared.fetchMaxItemId { id, error in
  // returns the current largest item id
	// example: 9127232
}
```

Fetch New, Top and Best Stories:
```swift
HNManager.shared.fetchNewStoriesIds { ids in
  // returns an array of up to 500 new stories ids
  // example: [ 9127232, 9128437, 9130049, 9130144, 9130064 ]
}

HNManager.shared.fetchTopStoriesIds { ids in
  // returns an array of up to 500 top stories ids
  // example: [ 9127232, 9128437, 9130049, 9130144, 9130064 ]
}

HNManager.shared.fetchBestStoriesIds { ids in
  // returns an array of up to 500 best stories ids
  // example: [ 9127232, 9128437, 9130049, 9130144, 9130064 ]
}
```

Fetch Ask, Show and Job stories:
```swift
HNManager.shared.fetchAskIds { ids, error in
  // returns an array of up to 200 latest Ask HN ids
  // example: [ 9127232, 9128437, 9130049, 9130144, 9130064 ]
}

HNManager.shared.fetchShowIds { ids, error in
  // returns an array of up to 200 latest Show HN ids
  // example: [ 9127232, 9128437, 9130049, 9130144, 9130064 ]
}

HNManager.shared.fetchJobsIds { ids, error in
  // returns an array of up to 200 latest Jobs HN ids
  // example: [ 9127232, 9128437, 9130049, 9130144, 9130064 ]
}
```

Fetch changed items and profiles:
```swift
HNManager.shared.fetchUpdates { items, profiles, error in
  // return arrays of changed items ids and profiles ids
  // items = [ 8423305, 8420805, 8423379, 8422504, 8394339, 8421900, 8420902, 8422087 ],
  // profiles = [ "thefox", "mdda", "plinkplonk", "arram", "MrZongle2", "Bogdanp" ]
}
```

# Structure

## Model:
  - [HNItem.swift](https://github.com/omaralbeik/HNClient/blob/master/Source/Model/HNItem.swift)
  - [HNItemType.swift](https://github.com/omaralbeik/HNClient/blob/master/Source/Model/HNItemType.swift)
  - [HNUser.swift](https://github.com/omaralbeik/HNClient/blob/master/Source/Model/HNUser.swift)

## Services:
  - [HNManager.swift](https://github.com/omaralbeik/HNClient/blob/master/Source/Services/HNManager.swift)

## Hacker News API:
 - This project relies on [Hacker News API](https://github.com/HackerNews/API)

## Dependencies:
  - HNClient uses [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper) for networking and mapping JSON to native objects.

# Requirements:
- iOS 8.0+
- Xcode 8.1+
- Swift 3.0+

# Installation

## CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate HNClient into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'HNClient'
end
```

Then, run the following command:

```bash
$ pod install
```

## Manually

Add the [Source](https://github.com/omaralbeik/HNClient/blob/master/Source/) folder to your Xcode project.


## License

HNClient is released under the MIT license. See [LICENSE](https://github.com/omaralbeik/HNClient/blob/master/LICENSE) for details.
