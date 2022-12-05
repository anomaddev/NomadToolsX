//
//  RouteController.swift
//  NomadTools
//
//  Created by Justin Ackermann on 5/28/21.
//

// Core iOS
import UIKit

// Utilities
import FAPanels
import Cartography
import NVActivityIndicatorView

open class RouteController: FAPanelController {
    
    public var activityoffset: NSLayoutConstraint!
    public lazy var activitydot: ActivityDot = ActivityDot()
    
    public var leftMenuWidth: CGFloat   = (UIScreen.main.bounds.width / 2) + 50
    public var rightMenuWidth: CGFloat  = UIScreen.main.bounds.width * 3/5
    
    override public init() {
        super.init()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
        configs.colorForTapView = UIColor.black.withAlphaComponent(0.1)
        configs.shouldAnimateWithPan = true
        configs.leftPanelWidth = leftMenuWidth
        configs.rightPanelWidth = rightMenuWidth
        configs.resizeLeftPanel = true
        configs.resizeRightPanel = true
        configs.canLeftSwipe = false
        configs.canRightSwipe = false
        configs.bounceOnLeftPanelOpen = false
        configs.bounceOnRightPanelOpen = true
        configs.maxAnimDuration = 0.25
        configs.centerPanelTransitionType = .crossDissolve
        configs.shadowColor = UIColor.clear.cgColor
        configs.unloadLeftPanel = false
        configs.unloadRightPanel = false
        configs.pusheSidePanels = false
        leftPanelPosition = .front
        rightPanelPosition = .back
        
        view.add(activitydot)
        constrain(activitydot)
        { view in
            let superview = view.superview!
            activityoffset = view.centerY == superview.centerY - 40
            view.centerX == superview.centerX
            view.height == 80
            view.width == view.height
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
