//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Shreya Pallan on 27/05/24.
//

import Foundation


func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 1)
}

func anyURL() -> URL {
    let url = URL(string: "https://a-url.com")!
    return url
}


