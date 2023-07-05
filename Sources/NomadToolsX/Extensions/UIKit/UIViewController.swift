//
//  UIViewController.swift
//  NomadTools
//
//  Created by Justin Ackermann on 7/5/21.
//

import UIKit

extension UIViewController {
    
    /// This finds the current UIScreen with context instead of a shared instance
    ///
    /// - returns: `UIScreen`
    ///
    public func screen() throws -> UIScreen {
        var parent = self.parent
        var lastParent = parent
        
        while parent != nil {
            lastParent = parent
            parent = parent!.parent
        }
        
        guard let screen = lastParent?.view.window?.windowScene?.screen
        else { throw NSError() }
        return screen
    }
}
