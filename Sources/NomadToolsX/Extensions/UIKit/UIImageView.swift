//
//  UIImageView.swift
//  NomadTools
//
//  Created by Justin Ackermann on 5/27/21.
//

import UIKit

public extension UIImageView {
//    convenience init(image: Image,
//                     tinted: UIColor! = .white) {
//        self.init(frame: .zero)
//        self.image = image.tinted(tinted)
//    }
    
    func change(to photo: UIImage?) {
        Nomad.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0
            }) { _ in
                self.image = photo
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.alpha = 1
                })
            }
        }
    }
}
