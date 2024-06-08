//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Shreya Pallan on 08/06/24.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
