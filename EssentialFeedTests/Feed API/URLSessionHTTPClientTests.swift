//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Shreya Pallan on 14/05/24.
//

import XCTest
import EssentialFeed


class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    struct UnexpectedValuesRepresentation: Error {}
    
    func get(url: URL, completion: @escaping (HTTPCLientResult) -> Void) {
        session.dataTask(with: url) { _,_, error in
            
            if let error = error  {
                completion(.failure(error))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
        
    }
}

final class URLSessionHTTPClientTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
        URLProtocolStub.startInterceptingRequests()

    }
    
    override class func tearDown() {
        super.tearDown()
        URLProtocolStub.stopInterceptingRequests()
    }

    func test_getFromURL_performsGETRequestWithSameURL() {
        
        let url = URL(string: "https://a-url.com")!
        let exp = expectation(description: "Wait for request")
        
        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.httpMethod, "GET")
            exp.fulfill()
        }
        
        makeSUT().get(url: anyURL()) { _ in }
        wait(for: [exp], timeout: 1.0)
    }

    func test_getFromURL_failsOnRequestError() {
                
        let requestedError = NSError(domain: "any error", code: 1)
        let error = resultErrorFor(data: nil, response: nil, error: requestedError)
        let receivedError = error as NSError?
        
        XCTAssertEqual(receivedError?.domain, requestedError.domain)
        XCTAssertEqual(receivedError?.code, requestedError.code)
    }
    

    //invalid case tests to test framework assumptions. These could be helpful if the framework changes.
    func test_getFromURL_failsOnAllNilValues() {
        XCTAssertNotNil(resultErrorFor(data: nil, response: nil, error: nil))
    }
    
    //MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> URLSessionHTTPClient {
        let sut =  URLSessionHTTPClient()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func anyURL() -> URL {
        let url = URL(string: "https://a-url.com")!
        return url
    }
    
    private func resultErrorFor(data: Data?, response: URLResponse?, error: Error?, file: StaticString = #file, line: UInt = #line) -> Error? {
        
        URLProtocolStub.stub(data: data, response: response, error: error)
        let sut = makeSUT(file: file, line: line)
    
        let exp = expectation(description: "wait for get to finish")
        
        var receivedError: Error?
        sut.get(url: anyURL()) { result in
            switch result {
            case let .failure(error):
                receivedError = error
            default:
                XCTFail("Expected failure, got \(result) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        return receivedError
    }

    private class URLProtocolStub: URLProtocol {
        
        private static var stub: Stub?
        private static var requestObserver: ((URLRequest) -> Void)?
        
        private struct Stub {
            let data: Data?
            let response: URLResponse?
            let error: Error?
        }
        
        static func observeRequests(observer: @escaping (URLRequest) -> Void) {
            requestObserver = observer
        }
        
        static func startInterceptingRequests() {
            URLProtocolStub.registerClass(URLProtocolStub.self)
        }
        
        static func stopInterceptingRequests() {
            URLProtocolStub.unregisterClass(URLProtocolStub.self)
            stub = nil
            requestObserver = nil
        }
        
        static func stub(data: Data?, response: URLResponse?, error: Error?) {
            stub = Stub(data: data, response: response, error: error)
        }
        
        override class func canInit(with request: URLRequest) -> Bool {
            requestObserver?(request)
            return true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        
        override func startLoading() {
    
            if let data = URLProtocolStub.stub?.data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            if let response = URLProtocolStub.stub?.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            if let error = URLProtocolStub.stub?.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        }
        
        override func stopLoading() {}
    }
    
}


