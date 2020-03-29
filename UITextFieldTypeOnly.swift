//
//  UITextFieldTypeOnly.swift
//  AcceptSDK
//
//  Created by Mohamed A Tawfik on Aug/3/17.
//  Copyright © 2017 mahmoud gamal. All rights reserved.
//

import Foundation
import UIKit  

class UITextFieldTypeOnly: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        switch(action){
            case #selector(UIResponderStandardEditActions.paste(_:)):
                fallthrough
            case #selector(UIResponderStandardEditActions.copy(_:)):
                fallthrough
            case #selector(UIResponderStandardEditActions.cut(_:)):
                fallthrough
            case #selector(UIResponderStandardEditActions.select(_:)):
                fallthrough
            case #selector(UIResponderStandardEditActions.selectAll(_:)):
                return false
            default:
                return super.canPerformAction(action, withSender: sender)
        }
    }
}
