//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Shreya Pallan on 01/05/24.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
