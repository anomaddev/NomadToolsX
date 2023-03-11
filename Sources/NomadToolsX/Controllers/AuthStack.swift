//
//  File.swift
//  
//
//  Created by Justin Ackermann on 3/10/23.
//

// Core iOS
import UIKit

// Utilities
import Cartography

final class AuthStack: UIView {
    
    lazy var title: Header = Header(style: .H2, alignment: .center)
    lazy var subtitle: Header = Header(alignment: .center)
    
    lazy var stack: Column = Column([
        .alignment(.fill),
        .distribution(.fillEqually),
        .spacing(20)
    ])
    
    private var btnattributes: [Attribute] = [
        .setHeight(50),
        .cornerRadius(5)
    ]
    
    init(login items: [Social]) {
        super.init(frame: .zero)
        
        for login in items {
            let btn: IconButton = IconButton([
                .text("Continue with \(login.label)"),
                .backgroundColor(login.color),
                .textColor(login.onColor),
                .tag(login.providerIndex!)
            ], alignment: .left)
            
            btn.icon.image = UIImage(named: "facebook", in: .module, compatibleWith: nil)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
            btn.addGestureRecognizer(tap)
            stack.addArrangedSubview(btn)
        }
        
        layoutIfNeeded()
    }
                
    @objc func tapped(_ sender: UITapGestureRecognizer!) {
        
    }
    
    required init?(coder: NSCoder)
    { super.init(coder: coder) }
}
