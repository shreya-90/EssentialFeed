//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Shreya Pallan on 25/05/24.
//

import Foundation


public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void

    func deleteCacheFeed(completion: @escaping DeletionCompletion)
    func insert(_ items: [FeedItem], timestamp: Date, completion: @escaping InsertionCompletion)

}
