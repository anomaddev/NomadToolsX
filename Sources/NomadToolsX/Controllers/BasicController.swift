//
//  BasicController.swift
//  abseil
//
//  Created by Justin Ackermann on 5/28/21.
//

import Foundation

// Core iOS
import UIKit
import AuthenticationServices

// Firebase
// import Firebase
// import GoogleMobileAds

// Utilities
import Cartography
import NVActivityIndicatorView
// import IQKeyboardManagerSwift
// import SwiftEntryKit
// import LBTATools

open class BasicController: UIViewController, UITextFieldDelegate {
    
//    var isAutoKeysMoverEnabled: Bool {
//        set { IQKeyboardManager.shared.enable = newValue }
//        get { IQKeyboardManager.shared.enable }
//    }
    
    public var isDismissKeysEnabled: Bool = false {
        didSet {
            if isDismissKeysEnabled
            { self.view.addGestureRecognizer(dismissTap) }
            else { self.view.removeGestureRecognizer(dismissTap) }
        }
    }
    
    public var opaque: Bool = true {
        didSet {
            if opaque { view.backgroundColor = .clear }
            else { view.backgroundColor = .background }
        }
    }
    
    lazy var dismissTap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }()
    
    public var activityoffset: NSLayoutConstraint!
    public lazy var activitydot: ActivityDot = ActivityDot()
    
    public var navigation: NavigationController?
    { navigationController as? NavigationController }
    
    open var route: RouteController?
    { panel as? RouteController }
    
    required public init?(coder: NSCoder) { super.init(coder: coder) }
    public init(attributes: [Attribute]! = []) {
        super.init(nibName: nil, bundle: nil)
        do { setAttributes(attributes) }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        if #available(iOS 13.0, *)
        { overrideUserInterfaceStyle = .light }
        
        view.add(activitydot)
        constrain(activitydot)
        { view in
            let superview = view.superview!
            activityoffset = view.centerY ~== superview.centerY - 40
            view.centerX ~== superview.centerX
            view.height ~== 80
            view.width ~== view.height
        }
        
        view.layoutIfNeeded()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Register to Apple ID credential revoke notification
        if #available(iOS 13.0, *) {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(appleIDStateDidRevoked(_:)),
                                                   name: ASAuthorizationAppleIDProvider.credentialRevokedNotification,
                                                   object: nil)
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if #available(iOS 13.0, *) {
            NotificationCenter.default.removeObserver(self,
                                                      name: ASAuthorizationAppleIDProvider.credentialRevokedNotification,
                                                      object: nil)
        }
    }
    
    open func setAttributes(_ attributes: [Attribute]) {
        for attribute in attributes {
            switch attribute {
            case .controllerView(let attrs): view.setView(attrs)
            case .opaque(let isOpaque): opaque = isOpaque
            default: break
            }
        }
    }
    
    // MARK: Error
    open func handle(_ error: Error) {
        activitydot.stop()
    }
    
    // MARK: Actions
    @objc open func endEditing(_ sender: Any!)
    { view.endEditing(true) }
    
    @objc func appleIDStateDidRevoked(_ notification: Notification) {
        // Make sure user signed in with Apple
        do { } // TODO: Log Out }
        catch { self.handle(error) }
    }
    
    @objc open func goBack(_ sender: Any!) {
        navigation?.popViewController(animated: true)
    }
    
    // MARK: TextFieldDelegates
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        isDismissKeysEnabled = true
        return true
    }

    open func textFieldDidEndEditing(_ textField: UITextField) {
        isDismissKeysEnabled = false
    }
    
    // MARK: Debug
    open func debug() {
        
    }
}

// MARK: - Delegates

//extension BasicViewController: GADBannerViewDelegate {
//    /// Tells the delegate an ad request loaded an ad.
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        print("adViewDidReceiveAd")
//    }
//
//    /// Tells the delegate an ad request failed.
//    func adView(_ bannerView: GADBannerView,
//                didFailToReceiveAdWithError error: GADRequestError) {
//        print("adView:didFailToReceiveAdWithError: \(error.whatsthiserror())")
//    }
//
//    /// Tells the delegate that a full-screen view will be presented in response
//    /// to the user clicking on an ad.
//    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
//        print("adViewWillPresentScreen")
//    }
//
//    /// Tells the delegate that the full-screen view will be dismissed.
//    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
//        print("adViewWillDismissScreen")
//    }
//
//    /// Tells the delegate that the full-screen view has been dismissed.
//    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
//        print("adViewDidDismissScreen")
//    }
//
//    /// Tells the delegate that a user click will open another app (such as
//    /// the App Store), backgrounding the current app.
//    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
//        print("adViewWillLeaveApplication")
//    }
//}
