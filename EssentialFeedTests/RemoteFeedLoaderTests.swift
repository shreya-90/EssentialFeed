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



final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromUrl() {
        
        let (_,client) = makeSUT()
        XCTAssertNil(client.requestedURL)
    }

    func test_init_requestsDataFromUrl() {
        let url = URL(string: "https://a-given-url.com")!
       
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
    }
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPCLient {
        var requestedURL: URL?
        
        func get(from url: URL) {
            requestedURL = url
        }
  
    }
}
