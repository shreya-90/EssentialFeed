//
//  FeedViewControllerTests.swift
//  EssentialFeediOSTests
//
//  Created by Shreya Pallan on 05/06/24.
//

import XCTest

final class FeedViewController {
    init(loader: FeedViewControllerTests.LoaderSpy) {
        
    }
}

class FeedViewControllerTests: XCTestCase {
    
    
    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        let _ = FeedViewController(loader: loader)
        
        XCTAssertEqual(loader.loadCount, 0)
    }
    
    //MARK:- Helpers
    
    class LoaderSpy {
        private(set) var loadCount: Int = 0
    }
}
