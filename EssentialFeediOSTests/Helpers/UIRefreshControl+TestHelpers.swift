//
//  UIRefreshControl+TestHelpers.swift
//  EssentialFeediOS
//
//  Created by Shreya Pallan on 08/06/24.
//

import UIKit

extension UIRefreshControl {
     func simulateUserInitiatedFeedReload() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: .valueChanged)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
