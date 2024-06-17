//
//  FeedViewControllerTests+Localization.swift
//  EssentialFeediOS
//
//  Created by Shreya Pallan on 13/06/24.
//

import Foundation
import XCTest
import EssentialFeediOS

func localized(_ key: String, file: StaticString = #file, line: UInt = #line) -> String {
    let table = "Feed"
    let bundle = Bundle(for: FeedViewController.self)
    let value = bundle.localizedString(forKey: key, value: nil, table: table)
    if value == key {
        XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
    }
    return value
}
