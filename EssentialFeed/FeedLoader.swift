//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Shreya Pallan on 01/05/24.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
