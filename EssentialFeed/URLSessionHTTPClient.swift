//
//  URLSessionHTTPClient.swift
//  EssentialFeed
//
//  Created by Shreya Pallan on 15/05/24.
//

import Foundation

public class URLSessionHTTPClient: HTTPCLient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    public func get(from url: URL, completion: @escaping (HTTPCLient.Result) -> Void) {
        session.dataTask(with: url) { data, response, error in
            
            completion(Result {
                if let error = error  {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }.resume()
    }
}
