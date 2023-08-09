//
//  UIButton.swift
//  
//
//  Created by Justin Ackermann on 8/8/23.
//

// Core iOS
import UIKit

public extension UIButton {
    
    /// animate the change in text on the button
    ///
    /// - parameter text: A `String` that you would like to put on the button
    ///
    func changeTo(text: String) {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            self.setTitle(text, for: .normal)

            UIView.animate(withDuration: 0.4, animations: {
                self.alpha = 1
                self.layoutIfNeeded()
            })
        }
    }
    
}
