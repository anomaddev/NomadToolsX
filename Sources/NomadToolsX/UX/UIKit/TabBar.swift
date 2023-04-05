//
//  TabBar.swift
//  NomadTools
//
//  Created by Justin Ackermann on 4/30/22.
//

// Core iOS
import UIKit

// Utilities
import Cartography

public protocol TabBarDelegate {
    func willTab(from oldTab: String, to newTab: String, at index: Int, old: Int)
    func didTab(to tab: String, at index: Int)
}

open class TabBar: UIView {
    
    public lazy var tab: Row = Row([
        .distribution(.fillEqually),
        .alignment(.fill),
        .spacing(15)
    ])
    
    private var _offset: ConstraintGroup = ConstraintGroup()
    public lazy var indicator: BlankView = BlankView([
        .cornerRadius(2),
        .setHeight(4),
        .setWidth(100),
        .backgroundColor(.primary)
    ])
    
    public var delegate: TabBarDelegate?
    
    public var currentIndex: Int = 0
    private var tabs: [String] = []
    
    public init() {
        super.init(frame: .zero)
        add(tab, indicator)
        constrain(tab, indicator)
        { tab, indicator in
            let superview = tab.superview!
            tab.top ~== superview.top
            tab.left ~== superview.left
            tab.center ~== superview.center
            tab.bottom ~== superview.bottom - 10
            
            indicator.top ~== tab.bottom
        }
    }
    
    public func tabs(_ tabs: [String]) {
        self.tabs = tabs
        for (i, atab) in tabs.enumerated() {
            let button = Button([
                .font(.Medium, size: 17),
                .textColor(.onBackground),
                .text(atab),
                .tag(i)
            ])
            
            button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
            tab.addArrangedSubview(button)
        }
        
        layoutIfNeeded()
        setTab(index: 0)
    }
    
    public func setTab(index: Int, animated: Bool! = true) {
        delegate?.willTab(from: tabs[currentIndex],
                          to: tabs[index],
                          at: index,
                          old: currentIndex)
        currentIndex = index
        let view = tab.arrangedSubviews[index]
        
        UIView.animate(withDuration: animated ? 0.3 : 0.001, delay: 0, options: .curveEaseInOut, animations: {
            constrain(view, self.indicator, replace: self._offset)
            { view, indicator in indicator.centerX ~== view.centerX }
            self.layoutIfNeeded()
        }) { _ in self.delegate?.didTab(to: self.tabs[index], at: index) }
    }
    
    @objc public func tapped(_ sender: UIButton!)
    { setTab(index: sender.tag) }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
