//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by Shreya Pallan on 12/06/24.
//

import Foundation

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}
