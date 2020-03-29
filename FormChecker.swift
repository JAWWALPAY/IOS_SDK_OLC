//
//  FormChecker.swift
//  AcceptSDK
//
//  Created by Mohamed A Tawfik on Aug/13/17.
//  Copyright © 2017 mahmoud gamal. All rights reserved.
//

import Foundation

class FormChecker {
    class func checkCardName(text: UITextField, error: UILabel) -> Bool {
        var noError = true
        if (text.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
           noError = false
        }
        error.isHidden = noError
        return noError
    }
    
    class func checkCardNumber(text: BKCardNumberField, error: UILabel) -> Bool {
        var noError = true
        if text.text != nil {
            if text.cardNumber.characters.count != 16 {
                error.text = "Invalid card number!"
                noError = false
            }
        } else {
            error.text = "Invalid card number!"
            noError = false
        }
        error.isHidden = noError
        return noError
    }
    
    class func checkDate(text: BKCardExpiryField, error: UILabel) -> Bool {
        var noError = true
        if let enteredDate = text.text {
            if enteredDate.characters.count != 7 {
                error.text = "Invalid date!"
                noError = false
            } else {
                if !isDateInFuture(dateTxt: text) {
                    error.text = "Expired card!"
                    noError = false
                }
            }
        } else {
            error.text = "Invalid date!"
            noError = false
        }
        error.isHidden = noError
        return noError
    }
    
    class func checkCVV(text: UITextFieldTypeOnly, error: UILabel) -> Bool {
        var noError = true
        if let enteredCVV = text.text {
            if enteredCVV.characters.count != 3 {
                error.text = "Invalid!"
                noError = false
            }
        } else {
            error.text = "Invalid!"
            noError = false
        }
        error.isHidden = noError
        return noError
    }
    
    class func isDateInFuture(dateTxt: BKCardExpiryField) -> Bool {
        let monthInt = dateTxt.dateComponents.month!
        let yearInt = dateTxt.dateComponents.year!
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        guard (yearInt > components.year! || (yearInt == components.year! && monthInt >= components.month!)) else {
            return false
        }
        
        return true
    }
}
