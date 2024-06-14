//
//  FeedViewAdapter.swift
//  EssentialFeediOS
//
//  Created by Shreya Pallan on 14/06/24.
//

import Foundation
import EssentialFeed
import UIKit

final class FeedViewAdapter: FeedView {
    
    private weak var controller: FeedViewController?
    private let imageLoader: FeedImageDataLoader
    
    init(controller: FeedViewController? = nil, imageLoader: FeedImageDataLoader) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(_ viewModel: FeedViewModel) {
        controller?.tableModel = viewModel.feed.map { model in
            let adapter = FeedImageDataLoaderPresentationAdapter<WeakRefVirtualProxy<FeedImageCellController>, UIImage>(model: model, imageLoader: imageLoader)
            
            let view = FeedImageCellController(delegate: adapter)
            
            adapter.presenter = FeedImagePresenter(view: WeakRefVirtualProxy(view), imageTransformer: UIImage.init)
            return view
        }
        
        guard Thread.isMainThread else  { DispatchQueue.main.async { [weak self] in self?.controller?.refreshControl?.endRefreshing()  }
            return
        }
        
    }
}
