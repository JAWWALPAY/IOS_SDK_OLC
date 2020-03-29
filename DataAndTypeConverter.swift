//
//  DataAndTypeConverter.swift
//  AcceptSDK
//
//  Created by Mohamed A Tawfik on Aug/10/17.
//  Copyright © 2017 mahmoud gamal. All rights reserved.
//

import Foundation

class DataAndTypeConverter {
    /**
    it extracts the required keys from the API response
    */
    class func dataToTargetDict(data: Data?, keys: [String]) -> [String : AnyObject]? {
        var dict: [String : AnyObject]? = nil
        do {
            let jsonOptional = try JSONSerialization.jsonObject(with: data!, options: [.allowFragments]) as? [String: AnyObject]
            if let json = jsonOptional {
                dict = [:]
                for key in keys {
                    dict![key] = json[key]
                }
            }
        } catch let error {
            print("Error converting data to dict == \(error.localizedDescription)")
        }
        return dict
    }
    /**
     it extracts the required keys from a URL
     */
    class func urlQueryToTargetDict(url: String?, keys: [String]) -> [String : AnyObject]? {
        var dict: [String : AnyObject] = [:]
        for key in keys {
            dict[key] = getQueryStringParameter(url: url, param: key) as AnyObject?
        }
        return dict
    }
    /**
     it extracts the required actual argument from a URL's query parameters
     */
    class func getQueryStringParameter(url: String?, param: String) -> String? {
        if let url = url, let urlComponents = URLComponents(string: url), let queryItems = (urlComponents.queryItems) {
            return queryItems.filter({ (item) in item.name == param }).first?.value!
        }
        return nil
    }
    
    /**
     it converts the payDict from JSON to struct
     */
    class func payDictToStruct(_ JSON: [String : AnyObject]) -> PayResponse {
        let response = PayResponse(amount_cents: (JSON["amount_cents"] as! NSString).integerValue,
                                   is_refunded: StringEditor.stringToBool(JSON["is_refunded"] as? String),
                                   is_capture: StringEditor.stringToBool(JSON["is_capture"] as? String),
                                   captured_amount: (JSON["captured_amount"] as! NSString).integerValue,
                                   source_data_type: JSON["source_data.type"] as! String,
                                   pending: StringEditor.stringToBool(JSON["pending"] as? String),
                                   is_3d_secure: StringEditor.stringToBool(JSON["is_3d_secure"] as? String),
                                   id: (JSON["id"] as! NSString).integerValue,
                                   is_void: StringEditor.stringToBool(JSON["is_void"] as? String),
                                   currency: JSON["currency"] as! String,
                                   is_auth: StringEditor.stringToBool(JSON["is_auth"] as? String),
                                   is_refund: StringEditor.stringToBool(JSON["is_refund"] as? String),
                                   owner: (JSON["owner"] as! NSString).integerValue,
                                   is_voided: StringEditor.stringToBool(JSON["is_voided"] as? String),
                                   source_data_pan: JSON["source_data.pan"] as! String,
                                   profile_id: (JSON["profile_id"] as! NSString).integerValue,
                                   success: StringEditor.stringToBool(JSON["success"] as? String),
                                   dataMessage: JSON["data.message"] as! String,
                                   source_data_sub_type: JSON["source_data.sub_type"] as! String,
                                   error_occured: StringEditor.stringToBool(JSON["error_occured"] as? String),
                                   is_standalone_payment: StringEditor.stringToBool(JSON["is_standalone_payment"] as? String),
                                   created_at: JSON["created_at"] as! String,
                                   refunded_amount_cents: (JSON["refunded_amount_cents"] as! NSString).integerValue,
                                   integration_id: (JSON["integration_id"] as! NSString).integerValue,
                                   order: (JSON["order"] as! NSString).integerValue)
        
        return response
    }
    
    /**
     it converts the saveCardDict from JSON to struct
     */
    class func saveCardDictToStruct(_ JSON: [String : AnyObject]) -> SaveCardResponse {
        let response = SaveCardResponse(card_subtype: JSON["card_subtype"] as! String,
                                        id: JSON["id"] as! Int, token: JSON["token"] as! String,
                                        created_at: JSON["created_at"] as! String,
                                        masked_pan: JSON["masked_pan"] as! String,
                                        merchant_id: JSON["merchant_id"] as! Int,
                                        order_id: JSON["order_id"] as? Int,
                                        email: JSON["email"] as? String)
        
        return response
    }
}
