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
    
    public init(_ asset: Asset, color: UIColor? = nil) {
        super.init(frame: .zero)
        if let color = color
        { tintColor = color }
        image = asset.image
    }
    
    func setAttributes(_ attributes: [Attribute]) {
        setView(attributes)
        for attribute in attributes {
            switch attribute {
            case .image(let img): image = img
            case .asset(let asset, let color):
                image = asset.image
                if let color = color
                { tintColor = color }
                
            case .icon(let icon, let color):
                image = icon.image
                tintColor = color
                
            default: break
            }
        }
    }
    
    required init?(coder: NSCoder)
    { super.init(coder: coder) }
}

