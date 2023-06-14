//
//  UIView.swift
//  NomadTools
//
//  Created by Justin Ackermann on 5/28/21.
//

import UIKit
import Cartography

public extension UIView {
    
    /// Init
    convenience init(color: UIColor)
    { self.init(); backgroundColor = color }
    
    /// Helpers
    func add(_ subviews: UIView...)
    { subviews.forEach(addSubview) }
    
    func remove(_ subview: UIView) throws {
        guard let view = subviews.first(where: { $0 == subview })
        else { throw NSError() } // THROW:
        view.removeFromSuperview()
    }
    
    /// Style
    func lockLight() {
        for view in subviews {
            if let text = view as? UILabel {
                text.overrideUserInterfaceStyle = .light
            }
        }
    }
    
    func lockDark() {
        for view in subviews {
            if let text = view as? UILabel {
                text.overrideUserInterfaceStyle = .dark
            }
        }
    }
    
    func addShadow(offset: CGSize! = CGSize(width: 1.0, height: 1.0),
                          color: UIColor! = .black,
                          radius: CGFloat! = 2.0,
                          opacity: Float! = 0.4,
                          round cornerRadius: CGFloat? = nil) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        if let corner = cornerRadius { layer.cornerRadius = corner }

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    /// Transforms
    private func rotate(degrees: Float! = 0, animated: Bool! = true) {
        Nomad.main.async {
            let duration: CGFloat = animated ? 0.25 : 0
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
                self.transform = self.transform.rotated(by: degrees.radians.cgfloat)
                self.layoutIfNeeded()
            })
        }
    }
    
    /// Animations
    func shake() {
        let animation = CABasicAnimation(keyPath: "shake_view")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        self.layer.add(animation, forKey: "shake_view")
    }
    
    func fadeOut(with duration: Double! = 0.25) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        })
    }
    
    func fadeIn(with duration: Double! = 0.4) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        })
    }
    
    /// Constraints
    @discardableResult
    func constrainHeight(_ constant: CGFloat) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.height = heightAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.height?.isActive = true
        return anchoredConstraints
    }
    
    @discardableResult
    func constrainWidth(_ constant: CGFloat) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.width = widthAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.width?.isActive = true
        return anchoredConstraints
    }
    
    /**
     This function adds the view, on which we call the function, to a specified parent view and afixes the constrains to the size of the parent view.
    
     ### Usage Example: ###
     ```swift
        let child = UIView()
        let parent = UIView()
    
        child.fitTo(parent)
     ```
     
     - parameter view: The `UIView` that you want to add this child view on to
    */
    func fitTo(_ view: UIView) {
        view.add(self)
        constrain(self)
        { theview in
            let superview = theview.superview!
            theview.center ~== superview.center
            theview.left ~== superview.left
            theview.bottom ~== superview.bottom
        }
        
        view.layoutIfNeeded()
    }
}
