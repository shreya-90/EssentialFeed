//
//  FeedViewControllerTests.swift
//  EssentialFeediOSTests
//
//  Created by Shreya Pallan on 05/06/24.
//

import XCTest
import UIKit
import EssentialFeed

final class FeedViewController: UIViewController {
    private var loader: FeedLoader?
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        loader?.load {_ in }
    }
}

class FeedViewControllerTests: XCTestCase {
    
    
    func test_init_doesNotLoadFeed() {
        let (_, loader) = makeSUT()
        
        XCTAssertEqual(loader.loadCount, 0)
    }
    
    func test_viewDidLoad_loadsFeed() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.loadCount, 1)
    }
    //MARK:- Helpers
    
    func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
    class LoaderSpy: FeedLoader {
        private(set) var loadCount: Int = 0

        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            loadCount += 1
        }
    }
}
