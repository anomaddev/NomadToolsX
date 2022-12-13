//
//  Errors.swift
//  
//
//  Created by Justin Ackermann on 12/12/22.
//

import Foundation

public extension Error {
    func whatsthiserror() {
        do { throw self }
        catch let error as DecodingError {
            switch error {
            case .typeMismatch(let key, let value):
                print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
            case .valueNotFound(let key, let value):
                print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
            case .keyNotFound(let key, let value):
                print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
            case .dataCorrupted(let key):
                print("error \(key), and ERROR: \(error.localizedDescription)")
            default:
                print("ERROR: \(error.localizedDescription)")
            }
            print()
        } catch {
            print(error.localizedDescription)
            print()
        }
    }
}
