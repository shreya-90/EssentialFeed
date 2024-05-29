//
//  XCTest+FailableRetrieveSpecs.swift
//  EssentialFeedTests
//
//  Created by Shreya Pallan on 29/05/24.
//

import XCTest
import EssentialFeed

extension FailableRetrieveSpecs where Self: XCTestCase {
    func assertThatRetrieveDeliversFailureOnRetrievalError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieveWith: .failure(anyNSError()), file: file, line: line)
    }

    func assertThatRetrieveHasNoSideEffectsOnFailure(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieveTwice: .failure(anyNSError()), file: file, line: line)
    }
}
