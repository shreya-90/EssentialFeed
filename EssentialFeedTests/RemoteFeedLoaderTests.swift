//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Shreya Pallan on 02/05/24.
//

import XCTest


class RemoteFeedLoader {
    
    func load() {
        HTTPCLient.shared.requestedURL = URL(string: "https://a-url.com")
    }
}

class HTTPCLient {
    static let shared = HTTPCLient()
    private init() {}
    var requestedURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromUrl() {
        let client = HTTPCLient.shared
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }

    func test_init_requestsDataFromUrl() {
        let client = HTTPCLient.shared
        let sut = RemoteFeedLoader()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
}
