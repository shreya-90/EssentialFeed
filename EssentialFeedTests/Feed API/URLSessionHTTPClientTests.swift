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
        session.dataTask(with: url) {_,_,_ in }.resume()
        
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

    func test_getFromURL_resumesDataTaskWithURL() {
        let url = URL(string: "https://a-url.com")!
        let session = URLSessionSpy()
        
        let sut = URLSessionHTTPClient(session: session)
        let task = URLSessionDataTaskSpy()
        session.stub(url: url, task: task)
        
        sut.get(url: url)
        
        XCTAssertEqual(task.resumeCallCount, 1)
    }
    
    private class URLSessionSpy: URLSession {
        
        var receivedURLs = [URL]()
        private var stubs = [URL: URLSessionDataTask] ()
        
        func stub(url: URL, task: URLSessionDataTask) {
            stubs[url] = task
        }
                
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            receivedURLs.append(url)
            return stubs[url] ?? FakeURLSessionDataTask()
        }
        
    }

    private class FakeURLSessionDataTask: URLSessionDataTask {
        override func resume() {}
    }
    
    private class URLSessionDataTaskSpy: URLSessionDataTask {
        var resumeCallCount = 0
        
        override func resume() {
            resumeCallCount += 1
        }
    }

}


