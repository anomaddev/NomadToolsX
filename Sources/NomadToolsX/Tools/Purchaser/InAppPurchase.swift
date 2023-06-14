//
//  InAppPurchase.swift
//  
//
//  Created by Justin Ackermann on 6/13/23.
//

import Foundation
import StoreKit

public protocol InAppPurchase {
    var id: String { get }
    var product: SKProduct { get }
}
