//
//  NomadToolsX.swift
//  NomadToolsX
//
//  Created by Justin Ackermann on 4/7/22.
//

// Core iOS
import UIKit
import AuthenticationServices
import CryptoKit

// MARK: Statement
protocol Statement {}

final public class Nomad {
    
    //    static let resourceBundle: Bundle = {
    //        let myBundle = Bundle(for: Nomad.self)
    //
    //        guard let resourceBundleURL = myBundle.url(forResource: "main", withExtension: "bundle")
    //        else { fatalError("NomadTools.bundle not found!") }
    //
    //        guard let resourceBundle = Bundle(url: resourceBundleURL)
    //        else { fatalError("Cannot access NomadTools.bundle!") }
    //
    //        return resourceBundle
    //    }()
    
    // Global Static Variables
    public static var backpack: Nomad = Nomad()
    public static var theme: AppTheme = AppTheme()
    
    public static var main: DispatchQueue { DispatchQueue.main }
//    public static var weather: Weather = Weather.get
    
    // Global Static Functions
    public static func bugging(_ msg: String! = "") {
        print("Pinged: \(msg)")
    }
    
    public static func delay(_ delay: Double,_ closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        Nomad.main.asyncAfter(deadline: when, execute: closure)
    }
    
    // Init
    private init() {
        Font.loadFonts()
    }
    
    // Haptic
    static func buzz(_ type: BuzzType! = .warning) {
        switch type {
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
        case .success:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        case .warning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            
        case .light:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
        case .medium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        case .heavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        default:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
    }
    
    // MARK: Utilities

    
    // MARK: Internals
    public enum BuzzType: Int {
        case error = 0
        case success
        case warning
        case light
        case medium
        case heavy
    }
}
