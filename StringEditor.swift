//
//  StringEditor.swift
//  AcceptSDK
//
//  Created by Mohamed A Tawfik on Aug/3/17.
//  Copyright © 2017 mahmoud gamal. All rights reserved.
//

import Foundation

class StringEditor {
    /**
     it inserts a character every n characters
     */
    class func insertCharacterEvery(n: Int, string: String, seperator: Character) -> String{
        var i = n
        var result = string
        while(i < string.characters.count){
            let index = string.index(string.startIndex, offsetBy: i)
            result.insert(seperator, at: index)
            i = i + n + 1
        }
        return result
    }
    /**
     it removez spaces from a string
     */
    class func removeSpaces(stringToEdit: String) -> String{
        return stringToEdit.replacingOccurrences(of: " ", with: "")
    }
    /**
     it truncates the last n characters from a string
     */
    class func truncateLast(n: Int, stringToEdit: String) -> String{
        let endIndex = stringToEdit.index(stringToEdit.endIndex, offsetBy: 0 - n)
        return stringToEdit.substring(to: endIndex)
    }
    /**
     it checks if the string contains only numbers
     */
    class func containsOnlyNumbers(stringToCheck: String) -> Bool{
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = stringToCheck.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return stringToCheck == numberFiltered
    }
    /**
     it returns a 2-digit month string
     */
    class func monthString(month: Int?) -> String?{
        if let month = month {
            if month < 1 || month > 12 {
                return nil
            } else if month < 10 {
                return ("0\(String(month))")
            } else {
                return String(month)
            }
        } else {
            return nil
        }
    }
    /**
     it returns a 2-digit year string
     */
    class func yearString(year: Int?) -> String?{
        if let year = year {
            let year_string = String(year)
            let startIndex = year_string.index(year_string.startIndex, offsetBy: 2)
            return year_string.substring(from: startIndex)
        } else {
            return nil
        }
    }
    /**
     it converts a string to bool
     */
    class func stringToBool(_ flag: String?) -> Bool {
        if flag == nil {
            return false
        } else {
            return flag == "true"
        }
    }
}
