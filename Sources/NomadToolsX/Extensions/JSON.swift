//
//  JSON.swift
//  
//
//  Created by Justin Ackermann on 7/5/23.
//

import Foundation

extension Data {
    
    /// This will take a JSON `Data` representation and returns the string version
    ///
    /// - returns: `String?` of the JSON data, note this is optional
    /// - throws: throws error if JSON data is invalid
    ///
    public func dataAsString() throws -> String?
    { String(data: self, encoding: .utf8) }
}
