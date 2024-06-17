//
//  UIRefreshControl+TestHelpers.swift
//  EssentialFeediOS
//
//  Created by Shreya Pallan on 08/06/24.
//

import UIKit

extension UIRefreshControl {
     func simulateUserInitiatedFeedReload() {
         simulate(event: .valueChanged)
    }
}
