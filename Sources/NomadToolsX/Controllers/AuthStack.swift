//
//  AuthStack.swift
//  
//
//  Created by Justin Ackermann on 3/10/23.
//

// Core iOS
import UIKit

// Utilities
import Cartography

public protocol AuthStateDelegate {
    func run(login: Social)
}

public class AuthStack: UIView {
    
    lazy var title: Header = Header(style: .H2, alignment: .center, height: 30)
    lazy var subtitle: Header = Header(alignment: .center, height: 25)
    
    lazy var stack: Column = Column([
        .alignment(.fill),
        .distribution(.fill),
        .spacing(0)
    ])
    
    private var btnattributes: [Attribute] = [
        .setHeight(50),
        .cornerRadius(5)
    ]
    
    public var calcHeight: CGFloat! = 0
    public var delegate: AuthStateDelegate?
    
    public init(logins items: [Social]) {
        super.init(frame: .zero)
        
        title.text = "Login to Atlas"
        subtitle.text = "Select how you would like to login"
        
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(subtitle)
        stack.addArrangedSubview(Spacer(h: 30))
        
        calcHeight = 85 + (items.count.cgfloat * 70)
        
        for login in items {
            let btn: IconButton = IconButton([
                .text("Continue with \(login.label)"),
                .backgroundColor(login.color),
                .textColor(login.onColor),
                .tag(login.providerIndex!)
            ] + btnattributes, alignment: .left)
            
            btn.icon.image = login.icon
            btn.icon.tintColor = login.onColor
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
            btn.addGestureRecognizer(tap)
            btn.addShadow()
            stack.addArrangedSubview(btn)
            stack.addArrangedSubview(Spacer(h: 20))
        }
        
        add(stack)
        constrain(stack)
        { stack in
            let superview = stack.superview!
            stack.top ~== superview.top
            stack.left ~== superview.left
            stack.center ~== superview.center
        }
        
        layoutIfNeeded()
    }
    
    // MARK: Actions
    @objc private func tapped(_ sender: UITapGestureRecognizer!) {
        guard let btn = sender.view as? IconButton,
              let login = Social(providerIndex: btn.tag)
        else { return } // THROW:
        self.delegate?.run(login: login)
    }
    
    required init?(coder: NSCoder)
    { super.init(coder: coder) }
}
