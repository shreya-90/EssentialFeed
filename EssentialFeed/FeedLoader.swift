//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Shreya Pallan on 01/05/24.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}


protocol FeedLoader {
    associatedtype Error: Swift.Error
    
    func load(completion: @escaping (LoadFeedResult<Error>) -> Void)
}
