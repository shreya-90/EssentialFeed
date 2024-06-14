//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Shreya Pallan on 10/06/24.
//

import Foundation
import EssentialFeed
import UIKit

public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let presentationAdapter = FeedLoaderPresentationAdapter(feedLoader: MainQueueDispatchDecorator(decoratee: feedLoader))
        let feedController = FeedViewController.makeWith(
            delegate: presentationAdapter,
            title: FeedPresenter.title)
        presentationAdapter.presenter = FeedPresenter(feedView: FeedViewAdapter(
            controller: feedController,
            imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader)),
            loadingView: WeakRefVirtualProxy(feedController))
        return feedController
    }
    
}

private extension FeedViewController {
    static func makeWith(delegate: FeedViewControllerDelegate, title: String) -> FeedViewController {
        let bundle = Bundle(for: FeedViewController.self)
        let storyBoard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedController = storyBoard.instantiateInitialViewController() as! FeedViewController
        feedController.delegate = delegate
        feedController.title = title
        return feedController
    }
}

final class FeedImageDataLoaderPresentationAdapter<View: FeedImageView, Image>: FeedImageCellControllerDelegate  where View.Image == Image {
    
    private let model: FeedImage
    private let imageLoader: FeedImageDataLoader
    private var task: FeedImageDataLoaderTask?

    var presenter: FeedImagePresenter<View, Image>?
    
    init(model: FeedImage, imageLoader: FeedImageDataLoader) {
        self.model = model
        self.imageLoader = imageLoader
    }
    
    func didRequestImage() {
        presenter?.didStartLoadingImageData(for: model)
        let model = self.model
        
        task = imageLoader.loadImageData(from: model.url) { [weak self] result in
            switch result {
            case let .success(data):
                self?.presenter?.didFinishLoadingImageData(with: data, for: model)
                
            case let .failure(error):
                self?.presenter?.didFinishLoadingImageData(with: error, for: model)
            }
        }
        
    }
    
    func didCancelImageRequest() {
            task?.cancel()
    }
}
