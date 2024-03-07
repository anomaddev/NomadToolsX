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
    
    public static var defaultConfig: FAPanelConfigurations = {
        var configs = FAPanelConfigurations()
        configs.colorForTapView = UIColor.black.withAlphaComponent(0.1)
        configs.shouldAnimateWithPan = true
        configs.leftPanelWidth = 300
        configs.rightPanelWidth = 200
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
        return configs
    }()
    
    public var activityoffset: NSLayoutConstraint!
    public lazy var activitydot: ActivityDot = ActivityDot()
    
//    public var leftMenuWidth: CGFloat   = (UIScreen.main.bounds.width / 2) + 50
//    { didSet { configs.leftPanelWidth = leftMenuWidth }}
//    
//    public var rightMenuWidth: CGFloat  = UIScreen.main.bounds.width * 3/5
//    { didSet { configs.rightPanelWidth = rightMenuWidth }}
    
    init(withConfig configs: FAPanelConfigurations) {
        super.init()
        self.configs = configs
        leftPanelPosition = .front
        rightPanelPosition = .back
    }
    
    override public init() {
        super.init()
        defaultSetup()
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        layoutActivity()
    }
    
    private func defaultSetup() {
        configs = Self.defaultConfig
        leftPanelPosition = .front
        rightPanelPosition = .back
    }
    
    private func layoutActivity() {
        view.backgroundColor = .white
        view.add(activitydot)
        constrain(activitydot)
        { view in
            let superview = view.superview!
            activityoffset = view.centerY ~== superview.centerY - 40
            view.centerX ~== superview.centerX
            view.height ~== 80
            view.width ~== view.height
        }
        
        view.layoutIfNeeded()
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
