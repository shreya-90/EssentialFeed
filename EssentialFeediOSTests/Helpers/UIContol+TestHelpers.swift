//
//  UIContol+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Shreya Pallan on 08/06/24.
//

import UIKit

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
