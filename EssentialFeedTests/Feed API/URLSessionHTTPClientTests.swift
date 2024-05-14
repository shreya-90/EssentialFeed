//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Shreya Pallan on 14/05/24.
//

import XCTest


class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(url: URL) {
        session.dataTask(with: url) {_,_,_ in }
    }
}

final class URLSessionHTTPClientTests: XCTestCase {

    func test_getFromURL_craetesDataTaskWithURL() {
        let url = URL(string: "https://a-url.com")!
        let session = URLSessionSpy()
        
        let sut = URLSessionHTTPClient(session: session)
        
        sut.get(url: url)
        
        XCTAssertEqual(session.receivedURLs, [url])
    }

    private class URLSessionSpy: URLSession {
        
        var receivedURLs = [URL]()
                
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            receivedURLs.append(url)
            return FakeURLSessionDataTask()
        }
        
    }

    private class FakeURLSessionDataTask: URLSessionDataTask { }
}


