//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by Shreya Pallan on 25/05/24.
//

import Foundation


public final class LocalFeedLoader {
    
    private let store: FeedStore
    private let currentDate: () -> Date
    
    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
    
    public func save(_ items: [FeedItem], completion: @escaping (Error?) -> Void) {
        store.deleteCacheFeed { [weak self] error in
            
            guard let self = self else { return }
            
            if let cacheDeletionError = error  {
                completion(cacheDeletionError)
            } else {
                
                self.cacheItems(items, with: completion)
            }
        }
    }
    
    private func cacheItems(_ items: [FeedItem], with completion: @escaping (Error?) -> Void){
        store.insert(items, timestamp: currentDate(), completion: { [weak self] error in
            guard self != nil else { return }
            completion(error)
        })
    }
}

