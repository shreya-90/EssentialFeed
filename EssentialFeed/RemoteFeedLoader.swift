//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Shreya Pallan on 02/05/24.
//

import Foundation

public protocol HTTPCLient {
    func get(from url: URL,  completion: @escaping (Error) -> Void)
}


public final class RemoteFeedLoader {
    
    private let url: URL
    private let client: HTTPCLient
    
    public enum Error: Swift.Error {
        case connectivity
    }
    
    public init(url: URL, client: HTTPCLient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Error) -> Void) {
        client.get(from: self.url) { error in
            completion(.connectivity)
        }
       
    }
}
