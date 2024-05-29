//
//  XCTestCase+FeedStoreSpec.swift
//  EssentialFeedTests
//
//  Created by Shreya Pallan on 29/05/24.
//

import XCTest
import EssentialFeed

extension FeedStoreSpec where Self: XCTestCase {
    
     func expect(_ sut: FeedStore, toRetrieveTwice expectedResult: RetrievedCachedFeedResult, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieveWith: expectedResult, file: file, line: line)
        expect(sut, toRetrieveWith: expectedResult, file: file, line: line)
    }
    
     func expect(_ sut: FeedStore, toRetrieveWith expectedResult: RetrievedCachedFeedResult, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Wait for load...")

        sut.retrieve { retrievedResult in
            switch (expectedResult, retrievedResult) {
            case (.empty, .empty),
                (.failure, .failure):
                break
                
            case let (.found(expected), .found(received)):
                XCTAssertEqual(expected.feed, received.feed, file: file, line: line)
                XCTAssertEqual(expected.timestamp, received.timestamp, file: file, line: line)
                
            default:
                XCTFail("Expected result \(expectedResult), got \(retrievedResult) instead")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }
    
    @discardableResult
     func insert(_ cache: (feed: [LocalFeedImage], timestamp: Date), to sut: FeedStore) -> Error? {
            let exp = expectation(description: "Wait for cache insertion")
            var insertionError: Error?
            sut.insert(cache.feed, timestamp: cache.timestamp) { receivedInsertionError in
                insertionError = receivedInsertionError
                exp.fulfill()
            }
            wait(for: [exp], timeout: 1.0)
            return insertionError
        }
    
    @discardableResult
     func deleteCache(from sut: FeedStore) ->  Error? {
        let exp = expectation(description: "Wait for cache deletion")
        var deletionError: Error?

        sut.deleteCacheFeed { receivedDeletionError in
            deletionError = receivedDeletionError
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return deletionError
    }
    
}
