//
//  NomadApp.swift
//  NomadToolsX
//
//  Created by Justin Ackermann on 4/7/22.
//

import UIKit

open class NomadApp: UIResponder, UIApplicationDelegate {
    
    static let version: String = "0.7.8"
    
    /// window
    open var window: UIWindow?
    
    /// debug
    public static var isDebugging: Bool = false
    open var debug: Bool = false {
        didSet { NomadApp.isDebugging = debug }
    }
    
    /// versions
    public static var build: UInt64? = {
        guard let b = Bundle.main.infoDictionary?["CFBundleVersion"] as? String,
              let i = UInt64(b)
        else { return nil }
        return i
    }()
    
    public static var appVersion: String? = {
        let app: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        guard let app = app
        else { return nil }
        return app + (isDebugging ? ".\(build ?? 0)" : "")
    }()
    
    public static var dbSchema: UInt64? = {
        guard let b = Bundle.main.infoDictionary?["DBSchemaVersion"] as? String,
              let i = UInt64(b)
        else { return nil }
        return i
    }()
    
    open func run(options: [UIApplication.LaunchOptionsKey: Any]? = nil,
                  on application: UIApplication) throws {
        if NomadApp.isDebugging { debugging() }
    }
    
    open func flags(_ flags: [RunFlag]) throws {
        flags.forEach {
            switch $0 {
            case .LogUnsatisfiable(let val):
                UserDefaults.standard.set(val, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            }
        }
    }
    
    open func debugging() {
        print("===================")
        print("Version: \(NomadApp.appVersion ?? "err")")
        print("Build: \(NomadApp.build ?? 999999)")
        print("Schema: \(NomadApp.dbSchema ?? 999999)")
        print("===================")
    }
    
    public func application(_ application: UIApplication,
                            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        do {
            // Firebase
//            FirebaseApp.configure()
            
            // Facebook
//            ApplicationDelegate.shared.application(
//                application,
//                didFinishLaunchingWithOptions: launchOptions
//            )
            
            try run(options: launchOptions, on: application)
            return true
        } catch {
            print(error.localizedDescription)
            print()
            fatalError()
        } // THROW:
    }
    
    public func setWindow(with root: UIViewController) throws {
        // Set navigation controller & initial controller within window without storyboard
        let rootNav = UINavigationController(rootViewController: root)
        rootNav.isToolbarHidden = true
        rootNav.isNavigationBarHidden = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.overrideUserInterfaceStyle = .light
        
        if let window = window {
            window.rootViewController = rootNav
            
            if #available(iOS 13.0, *)
            { window.overrideUserInterfaceStyle = .light }
            
            window.makeKeyAndVisible()
        } else { throw NSError() } // THROW:
    }
    
    // Run Flags
    public enum RunFlag {
        case LogUnsatisfiable(Bool)
    }
}
