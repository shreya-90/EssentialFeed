//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Shreya Pallan on 02/05/24.
//

import Foundation

public protocol HTTPCLient {
    func get(from url: URL)
}


public final class RemoteFeedLoader {
    
    private let url: URL
    private let client: HTTPCLient
    
    public init(url: URL, client: HTTPCLient) {
        self.url = url
        self.client = client
    }
    
    public func load() {
        client.get(from: self.url)
    }
}
