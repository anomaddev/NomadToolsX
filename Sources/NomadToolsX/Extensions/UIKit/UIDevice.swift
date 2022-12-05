//
//  UIDevice.swift
//  NomadTools
//
//  Created by Justin Ackermann on 8/16/21.
//

import UIKit

public extension UIDevice {
    @available(iOS 13.0, *)
    static func vibrate(_ style: UIImpactFeedbackGenerator.FeedbackStyle! = .soft) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
