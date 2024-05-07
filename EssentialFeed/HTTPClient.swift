//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Shreya Pallan on 07/05/24.
//

import Foundation

public enum HTTPCLientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPCLient {
    func get(from url: URL,  completion: @escaping (HTTPCLientResult) -> Void)
}
