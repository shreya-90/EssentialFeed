//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Shreya Pallan on 01/05/24.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>

    func load(completion: @escaping (Result) -> Void)
}
