//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Shreya Pallan on 02/05/24.
//

import Foundation

public enum HTTPCLientResult {
    case success(HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPCLient {
    func get(from url: URL,  completion: @escaping (HTTPCLientResult) -> Void)
}


public final class RemoteFeedLoader {
    
    private let url: URL
    private let client: HTTPCLient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL, client: HTTPCLient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Error) -> Void) {
        client.get(from: self.url) { result in
            
            switch result {
            case .success:
                completion(.invalidData)
            case .failure:
                completion(.connectivity)
            }
        }
    }
}
