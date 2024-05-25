//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Shreya Pallan on 25/05/24.
//

import Foundation

struct RemoteFeedItem: Decodable {
     let id: UUID
     let description: String?
     let location: String?
     let image: URL
}
