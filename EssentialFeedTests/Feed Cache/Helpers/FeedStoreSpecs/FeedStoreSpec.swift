//
//  CodableFeedStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by Shreya Pallan on 29/05/24.
//

import Foundation

protocol FeedStoreSpec {
     func test_retrieve_deliversEmptyOnEmptyCache()
     func test_retrieve_hasNoSideEffectsOnEmptyCache()
     func test_retrieve_deliversFoundValuesOnNonEmptyCache()
     func test_retrieve_hasNoSideEffectsOnNonEmptyCache()

     func test_insert_overridesPreviouslyInsertedCacheValues()

     func test_delete_hasNoSideEffectsOnEmptyCache()
     func test_delete_emptiesPreviouslyInsertedCache()
    
     func test_storeSideEffects_runSerially()
}

protocol FailableRetrieveFeedStoreSpecs: FeedStoreSpec {
    func test_retrieve_deliversFailureOnRetrievalError()
    func test_retrieve_hasNoSideEffectsOnFailure()
}

protocol FailableInsertFeedStoreSpecs: FeedStoreSpec {
    func test_insert_deliversErrorOnInsertionError()
    func test_insert_noSideEffectsOnInsertionError()
}

protocol FailableDeleteFeedStoreSpecs: FeedStoreSpec {
    func test_delete_deliversErrorOnDeletionError()
    func test_delete_hasNoSideEffectsOnDeletionError()
}

typealias FailableFeedStoreSpec = FailableRetrieveFeedStoreSpecs & FailableInsertFeedStoreSpecs & FailableDeleteFeedStoreSpecs
