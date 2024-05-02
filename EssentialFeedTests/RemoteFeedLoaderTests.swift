//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Shreya Pallan on 02/05/24.
//

import XCTest


class RemoteFeedLoader {
    
}

class HTTPCLient {
    var requestedURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromUrl() {
        let client = HTTPCLient()
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }

}
