//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Shreya Pallan on 02/05/24.
//

import XCTest


class RemoteFeedLoader {
    let client: HTTPCLient
    let url: URL
    
    init(url: URL, client: HTTPCLient) {
        self.url = url
        self.client = client
    }
    
    func load() {
        client.get(from: self.url)
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
        
        let url = URL(string: "https://a-url.com")!
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(url: url, client: client)
        
        XCTAssertNil(client.requestedURL)
    }

    func test_init_requestsDataFromUrl() {
        let url = URL(string: "https://a-given-url.com")!
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
    }
}
