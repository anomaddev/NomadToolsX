//
//  ImageView.swift
//  NomadTools
//
//  Created by Justin Ackermann on 3/21/22.
//

import UIKit

public class ImageView: UIImageView, Attributed {
    public var defaultAttributes: [Attribute] = [
        .contentMode(.scaleAspectFit)
    ]
    
    init(_ image: Image, tinted color: UIColor? = nil) {
        guard let img = image.image
        else { super.init(frame: .zero); return }
        
        super.init(frame: .square(img.size.height))
        self.image = color != nil ? image.tint() : image.image
        contentMode = .scaleAspectFit
    }
    
    public init(named image: String? = nil) {
        super.init(frame: .zero)
        if let image = image
        { self.image = UIImage(named: image) }
        contentMode = .scaleAspectFit
    }
    
    public init(_ attributes: [Attribute]) {
        super.init(frame: .zero)
        self.setAttributes(attributes)
        
    }
    
    func setAttributes(_ attributes: [Attribute]) {
        setView(attributes)
        for attribute in attributes {
            switch attribute {
            default: break
            }
        }
    }
    
    required init?(coder: NSCoder)
    { super.init(coder: coder) }
}

