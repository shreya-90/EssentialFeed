//
//  CoreDataFeedStore.swift
//  EssentialFeed
//
//  Created by Shreya Pallan on 31/05/24.
//

import Foundation

public final class CoreDataFeedStore: FeedStore {
    
    public init() {
        
    }
    
    public func deleteCacheFeed(completion: @escaping DeletionCompletion) {
        
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }
    
    
}
