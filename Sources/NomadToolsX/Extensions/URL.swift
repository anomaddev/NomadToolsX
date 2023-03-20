//
//  URL.swift
//  
//
//  Created by Justin Ackermann on 3/19/23.
//

import Foundation

extension URL {
    public init(_ staticString: StaticString)
    { self.init(string: "\(staticString)")! }
}
