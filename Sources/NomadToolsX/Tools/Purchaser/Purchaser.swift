//
//  Purchaser.swift
//  
//
//  Created by Justin Ackermann on 6/13/23.
//

import Foundation
import StoreKit

class Purchaser: NSObject {
    static let shared = Purchaser()
    
    private override init() {
        super.init()
    }
}
