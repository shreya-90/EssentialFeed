//
//  FeedViewController.swift
//  EssentialFeediOS
//
//  Created by Shreya Pallan on 06/06/24.
//

import UIKit
import EssentialFeed


final public class FeedViewController: UITableViewController {
    private var loader: FeedLoader?
    
    private var onViewIsAppearing: ((FeedViewController) -> Void)?
    
    public convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
        
        load()
        onViewIsAppearing = { vc in
            vc.refresh()
            vc.onViewIsAppearing = nil
        }
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        onViewIsAppearing?(self)
    }
    
    @objc private func load() {
        refreshControl?.beginRefreshing()
        loader?.load { [weak self ]_ in
            self?.refreshControl?.endRefreshing()
        }
    }
    
    @objc private func refresh() {
        refreshControl?.beginRefreshing()
    }
}