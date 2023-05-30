//
//  UIKit+Animations.swift
//  
//
//  Created by Justin Ackermann on 5/29/23.
//

import UIKit

public enum UIAnimationOptions {
    
    case animateOut(UIView.AnimationOptions)
    case animateIn(UIView.AnimationOptions)
    
}

public struct AnimatedFade {
    
    public var curve: UIView.AnimationOptions! = .curveLinear
    public var delay: Double! = 0
    public var duration: Double! = 0.3
    
}

public struct FadeOutIn {
    
    public var animateOut: AnimatedFade! = AnimatedFade()
    public var animateIn: AnimatedFade! = AnimatedFade()
    
    public init() {
        animateOut = AnimatedFade()
        animateIn = AnimatedFade()
    }
}

// MARK: - UIView
extension UIView {
    
    
}

// MARK: - UILabel
extension UILabel {
    
    /// Fades out label, changes text, fades back in
    ///
    /// - parameter text: `String` of text you would like to display on the label
    /// - parameter options: Takes a `FadeOutIn` Animation object to determine the animation parameters.
    ///
    /// # Notes: #
    ///
    ///
    /// # Example #
    /// ```
    ///
    /// ```
    public func fadeNChangeTo(text: String,
                              color: UIColor! = .onBackground,
                              with options: FadeOutIn! = FadeOutIn(),
                              _ completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: options.animateOut.duration,
                       delay: options.animateOut.delay,
                       options: options.animateOut.curve,
                       animations: {
            self.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            self.text = text
            self.textColor = color
            UIView.animate(withDuration: options.animateIn.duration,
                           delay: options.animateIn.delay,
                           options: options.animateIn.curve,
                           animations: {
                self.alpha = 1
                self.layoutIfNeeded()
            }) { completion?($0) }
        }
    }
    
    // TODO: Add documentation
    public func fadeNChangeTo(attributedText: NSMutableAttributedString) {
        
    }
}

// MARK: UIButton
extension UIButton {
    /// Fades out button, changes text, fades back in
    ///
    /// - parameter text: `String` of text you would like to display on the label
    /// - parameter options: Takes a `FadeOutIn` Animation object to determine the animation parameters.
    ///
    /// # Notes: #
    ///
    ///
    /// # Example #
    /// ```
    ///
    /// ```
    public func fadeNChangeTo(text: String,
                              color: UIColor! = .onBackground,
                              with options: FadeOutIn! = FadeOutIn(),
                              _ completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: options.animateOut.duration,
                       delay: options.animateOut.delay,
                       options: options.animateOut.curve,
                       animations: {
            self.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            self.setTitle(text, for: .normal)
            self.setTitleColor(color, for: .normal)
            UIView.animate(withDuration: options.animateIn.duration,
                           delay: options.animateIn.delay,
                           options: options.animateIn.curve,
                           animations: {
                self.alpha = 1
                self.layoutIfNeeded()
            }) { completion?($0) }
        }
    }
    
    /// Fades out button, changes image, fades back in
    ///
    /// - parameter icon: `UIImage` of text you would like to display on the label
    /// - parameter tinted: `UIColor` for the icon to be draw with
    /// - parameter options: Takes a `FadeOutIn` Animation object to determine the animation parameters.
    ///
    /// # Notes: #
    ///
    ///
    /// # Example #
    /// ```
    ///
    /// ```
    public func fadeNChangeTo(icon: UIImage? = nil,
                              tinted: UIColor! = .onBackground,
                              with options: FadeOutIn! = FadeOutIn(),
                              _ completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: options.animateOut.duration,
                       delay: options.animateOut.delay,
                       options: options.animateOut.curve,
                       animations: {
            self.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            self.setImage(icon, for: .normal)
            self.tintColor = tinted
            UIView.animate(withDuration: options.animateIn.duration,
                           delay: options.animateIn.delay,
                           options: options.animateIn.curve,
                           animations: {
                self.alpha = 1
                self.layoutIfNeeded()
            }) { completion?($0) }
        }
    }
}
