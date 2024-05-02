//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Shreya Pallan on 02/05/24.
//

import XCTest


class RemoteFeedLoader {
    let client: HTTPCLient
    
    init(client: HTTPCLient) {
        self.client = client
    }
    
    func load() {
        client.get(from: URL(string: "https://a-url.com")!)
    }
}

protocol HTTPCLient {
    func get(from url: URL)
}

class HTTPClientSpy: HTTPCLient {
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromUrl() {
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(client: client)
        
        XCTAssertNil(client.requestedURL)
    }

    func test_init_requestsDataFromUrl() {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(client: client)
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
}
