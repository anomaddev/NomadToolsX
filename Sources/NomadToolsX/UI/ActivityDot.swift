//
//  ActivityDot.swift
//  twelve-months
//
//  Created by Justin Ackermann on 11/25/20.
//

// Core iOS
import UIKit

// Utilities
import Cartography
import NVActivityIndicatorView

open class ActivityDot: UIView {
    
    public lazy var ping: NVActivityIndicatorView = {
        let view = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100),
                                           type: .ballClipRotatePulse,
                                           color: Nomad.theme.onBackground,
                                           padding: 20)
        return view
    }()
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        backgroundColor = Nomad.theme.background
        layer.masksToBounds = true
        layer.cornerRadius = 40
        addShadow()
        alpha = 0
        
        add(ping)
        constrain(ping)
        { ping in
            let superview = ping.superview!
            ping.center == superview.center
            ping.height == 80
            ping.width == ping.height
        }
    }
    
    public func start() {
        ping.startAnimating()
        superview?.bringSubviewToFront(self)
        UIView.animate(withDuration: 0.4,
                       animations: { self.alpha = 1 })
        layoutIfNeeded()
    }
    
    public func stop() {
        ping.stopAnimating()
        UIView.animate(withDuration: 0.4,
                       animations: { self.alpha = 0 })
        superview?.sendSubviewToBack(self)
        layoutIfNeeded()
    }
    
    public required init?(coder: NSCoder)
    { super.init(coder: coder) }
}
