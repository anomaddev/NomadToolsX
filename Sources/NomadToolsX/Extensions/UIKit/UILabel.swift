//
//  UILabel.swift
//  
//
//  Created by Justin Ackermann on 12/30/22.
//

import UIKit

public extension UILabel {
    /// Animate a change of text on a `UILabel`
    ///
    /// - parameter text: The `String` of text that we want to change the label to.
    /// - parameter durationOut: A `Double` value for the fade out animation duration in seconds.
    /// - parameter durationIn: A `Double` value for the fade in animation duration in seconds.
    ///
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
    
    /// This function sets the line hieght for each line of text in a UILabel. Call this function after you have set your text to the label.
    ///
    /// - Parameter lineSpacing: the spacing between each line of text in the UILabel
    /// - Parameter lineHeight: height of each line of text in the UILabel
    ///
    /// Example setting the line height
    ///  ```
    ///  let label = UILabel()
    ///  label.text = "Set the text"
    ///  label.set(lineSpacing: 1.1, lineHeight: 24)
    ///  ```
    func set(lineSpacing: CGFloat = 0.0, lineHeight: CGFloat = 0.0) {
        guard let labelText = self.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeight
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        // (Swift 4.1 and 4.0) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
    
    /// This function will set the spacing between each character of text in a UILabel
    ///
    /// - parameter characterSpacing: setting the spacing value will put more space between each charater in the label
    ///
    ///  Example setting the spacing
    ///  ```
    ///  let label = UILabel()
    ///  label.text = "Set the spacing next"
    ///  label.set(characterSpacing: 1.4)
    ///  ```
    func set(characterSpacing: Double = 1.25) {
        guard let text = text, !text.isEmpty else { return }
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: string.length - 1))
        attributedText = string
    }
}



