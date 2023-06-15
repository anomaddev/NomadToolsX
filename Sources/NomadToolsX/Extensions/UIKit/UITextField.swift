//
//  UITextField.swift
//  NomadTools
//
//  Created by Justin Ackermann on 3/22/22.
//

// Core iOS
import UIKit

// Utilities
import Cartography

@available(iOS 13.4, *)
extension UITextField {
    public static let kPlusMinused: Notification.Name = .init(rawValue: "kPlusMinused")
    
    public func addNumericAccessory(addPlusMinus: Bool) {
        let numberToolbar = UIToolbar()
        numberToolbar.barStyle = UIBarStyle.default
        
        var accessories : [UIBarButtonItem] = []
        
        if addPlusMinus {
            accessories.append(UIBarButtonItem(title: "+/-", style: UIBarButtonItem.Style.plain, target: self, action: #selector(plusMinusPressed)))
            accessories.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))   //add padding after
        }
        
        accessories.append(UIBarButtonItem(title: "Clear", style: UIBarButtonItem.Style.plain, target: self, action: #selector(numberPadClear)))
        accessories.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))   //add padding space
        accessories.append(UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(numberPadDone)))
        
        numberToolbar.items = accessories
        numberToolbar.sizeToFit()
        
        inputAccessoryView = numberToolbar
    }
    
    @objc func numberPadDone() {
        self.resignFirstResponder()
    }
    
    @objc func numberPadClear() {
        self.text = ""
    }
    
    @objc func plusMinusPressed() {
        guard let currentText = self.text else {
            return
        }
        if currentText.hasPrefix("-") {
            let offsetIndex = currentText.index(currentText.startIndex, offsetBy: 1)
            let substring = currentText[offsetIndex...]  //remove first character
            self.text = String(substring)
        }
        else {
            self.text = "-" + currentText
        }
        
        NotificationCenter.default.post(name: Self.kPlusMinused, object: nil, userInfo: [
            "value": self.text,
            "tag": self.tag
        ])
    }
    
    /// Sets the text field to return with a date picker for the input view
    ///
    /// # Notes: #
    ///
    ///
    /// # Example: #
    /// ```swift
    /// textField.setDatePicker(target: self, selector(selectedDate))
    /// ```
    ///
    /// - parameter target: Target of the action
    /// - parameter selector: Selector action once the date is chosen
    ///
    public func setDatePicker(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 200.0))
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .compact
            datePicker.sizeToFit()
        }
        
        self.inputView = datePicker
        
//        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 40.0))
//        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tapCancel))
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let done = UIBarButtonItem(title: "Done", style: .done, target: nil, action: selector)
//        toolBar.setItems([cancel, flexibleSpace, done], animated: false)
//        self.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}
