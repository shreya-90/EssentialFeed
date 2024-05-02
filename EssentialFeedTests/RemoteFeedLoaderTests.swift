//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Shreya Pallan on 02/05/24.
//

import XCTest


class RemoteFeedLoader {
    
    func load() {
        HTTPCLient.shared.get(from: URL(string: "https://a-url.com")!)
    }
}

class HTTPCLient {
    static var shared = HTTPCLient()
    
    func get(from url: URL) {
    }
    
}

class HTTPClientSpy: HTTPCLient {
    var requestedURL: URL?
    
    override func get(from url: URL) {
        requestedURL = url
    }
}

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromUrl() {
        let client = HTTPClientSpy()
        HTTPCLient.shared = client
        
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }

    func test_init_requestsDataFromUrl() {
        let client = HTTPClientSpy()
        HTTPCLient.shared = client
        let sut = RemoteFeedLoader()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
}
