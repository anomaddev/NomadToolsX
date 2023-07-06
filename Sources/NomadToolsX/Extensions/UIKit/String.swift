//
//  String.swift
//  NomadTools
//
//  Created by Justin Ackermann on 7/14/21.
//

// Core iOS
import UIKit
import AuthenticationServices
import CryptoKit

// Utilities
import UIColorHexSwift

public extension String.SubSequence {
    var string: String
    { String(self) }
}

public extension String {
    
    static func random(length: Int) -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    // MARK: - is/isnot
    
    /// is `String` a valid email address
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    // TODO: Check Username
    
    /// number
    var int: Int?
    { Int(self) }
    
    /// transforms
    var string: String
    { String(self) }
    
    var color: UIColor
    { UIColor(self) }
    
    /// date
    var serverTime: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
    
    /// functions
    func attributed(attributes: [NSAttributedString.Key: Any]) -> NSAttributedString
    { NSAttributedString(string: self, attributes: attributes) }
    
    var attributed: NSAttributedString
    { NSAttributedString(string: self) }
    
    func dup(_ int: Int! = 1) -> [String] {
        guard int > 1 else { return [self] }
        var duplicates: [String] = []
        for _ in 1...int
        { duplicates.append(self) }
        return duplicates
    }
    
    func generateQRCode() -> UIImage? {
        let data = data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    /// authentication
    @available(iOS 13, *)
    func sha256() -> String {
        let inputData = Data(self.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    @available(iOS 13, *)
    static func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result.sha256()
    }
    
    // Initilizers
    
}

public extension NSAttributedString {
    var mutable: NSMutableAttributedString
    { NSMutableAttributedString(attributedString: self) }
}

public extension NSMutableAttributedString {
    var attributed: NSAttributedString
    { NSAttributedString(attributedString: self) }
}
