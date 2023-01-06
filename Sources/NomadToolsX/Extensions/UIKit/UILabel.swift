//
//  UILabel.swift
//  
//
//  Created by Justin Ackermann on 12/30/22.
//

import UIKit

public extension UILabel {
    func changeTo(text: String? = nil,
                durationOut: Double! = 0.25,
                durationIn: Double! = 0.4) {
        UIView.animate(withDuration: durationOut, animations: {
            self.alpha = 0
        }) { _ in
            self.text = text
            UIView.animate(withDuration: durationIn, animations: {
                self.alpha = 1
            })
        }
    }
}
