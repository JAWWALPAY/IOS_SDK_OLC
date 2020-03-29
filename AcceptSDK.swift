//
//  Accept.swift
//  handles api calls to accept api
//  Created by mahmoud gamal on 7/12/17.
//
//

import Foundation
import UIKit

typealias completed = (Data?, URLResponse?, Error?) -> ()

struct Constants {
    static let PAY_DICT_KEYS = ["amount_cents", "is_refunded", "is_capture", "captured_amount", "source_data.type", "pending", "is_3d_secure", "id", "is_void", "currency", "is_auth", "is_refund", "owner", "is_voided", "source_data.pan", "profile_id", "success", "data.message", "source_data.sub_type", "error_occured", "is_standalone_payment", "created_at", "refunded_amount_cents", "integration_id", "order"]
    static let SAVE_CARD_DICT_KEYS = ["order_id", "card_subtype", "id", "email", "token", "created_at", "masked_pan", "merchant_id"]
    
    static let baseURL = "https://accept.paymobsolutions.com/api/acceptance"
    static let stopping3dSecureURL = Constants.baseURL + "/post_pay"
}

/// handles api requests to accept api
public class AcceptSDK {
    public weak var delegate: AcceptSDKDelegate?

    var payVC : PayVCNew?
    
    public init(){}
    
    
    /**
    it shows accept's pay UIViewController.
     - Parameter vC: The UIViewController you use accept SDK from
     - Parameter billingData: the billing data you used to generate payment key
     - Parameter paymentKey: The payment key you get from the accept api in step 3
     - Parameter token: in case the user card data is saved
     - Parameter maskedPanNumber: can't be nil if token is passed. Isn't checked if token is nil
     - Parameter saveCardFlag: either show the user they can save their card data or not
     - Parameter showAlertsFlag: either show the user some alerts on success / failure or not
     - Parameter buttonsColor: pay button background color and save card switch onTint color. Defaults to light green if passed as nil
     */
    public func presentPayVC(vC: UIViewController, paymentKey: String, iFrame:String) throws {
        
        let bundle = Bundle(for: PayVCNew.classForCoder())
        payVC = bundle.loadNibNamed("PayVCNew", owner: vC, options: nil)?.first as? PayVCNew
        
        payVC?.accept = self

        payVC?.iFrame = iFrame
        
       
        
        payVC?.paymentKey = paymentKey
        vC.present(payVC!, animated: true, completion: nil)
    }
    
    /**
     it makes pay request to accept api
     - Parameter billingData: the billing data you used to generate payment key
     - Parameter cardData: the card data pay ViewController gets from the user
     - Parameter paymentKey: The payment key you get from the accept api in step 3
     - Parameter switchSaveCardValue: the switch if the user choose to save his card data
     - Parameter token: in case the user card data is saved
     - Parameter completionHandler: to handle the api response
     */
//    func payApiRequest(billingData: [String: String], cardData: [String: String], paymentKey: String, switchSaveCardValue: Bool?, completionHandler: @escaping completed) {
//        let urlString = URL(string: Constants.baseURL + "/payments/pay")
//        let request = NSMutableURLRequest(url: urlString!)
//        request.httpMethod = "POST"
//        request.cachePolicy = .reloadIgnoringCacheData
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let json = ["source": cardData,"billing": billingData, "payment_token": paymentKey] as [String : Any]
//        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//        do {
//            request.httpBody = jsonData
//            let task = URLSession.shared.dataTask(with: (request as URLRequest)) { (data, response, error) in
//                DispatchQueue.main.async {
//                    completionHandler(data, response, error)
//                }
//            }
//            task.resume()
//        }
//    }
    
    /**
     it makes save card request to accept api
     - Parameter cardData: the card data pay ViewController gets from the user
     - Parameter paymentKey: The payment key you get from the accept api in step 3
     - Parameter completionHandler: to handle the api response
     */
//    func saveCardApiRequest(cardData: [String: String], paymentKey: String, completionHandler: @escaping completed) {
//        let urlString = URL(string: Constants.baseURL + "/tokenization?payment_token=\(paymentKey)")
//        let request = NSMutableURLRequest(url: urlString!)
//        request.httpMethod = "POST"
//        request.cachePolicy = .reloadIgnoringCacheData
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        let json = cardData
//        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//        do {
//            request.httpBody = jsonData
//            let task = URLSession.shared.dataTask(with: (request as URLRequest)) { (data, response, error) in
//                DispatchQueue.main.async {
//                    completionHandler(data, response, error)
//                }
//            }
//            task.resume()
//        }
//    }
    
    /**
     This method is no longer used. The API it provides is not needed
     
     it gets the response from the api
     - Parameter paymentKey: The payment key you get from the accept api in step 3
     - Parameter completionHandler: to handle the api response
     */
//    func paymentKeyInquiryRequest(paymentKey: String, completionHandler: @escaping completed) {
//        let urlString = URL(string: Constants.baseURL + "/payments/payment_key_inquiry")
//        let request = NSMutableURLRequest(url: urlString!)
//        request.httpMethod = "POST"
//        request.cachePolicy = .reloadIgnoringCacheData
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        let json = ["payment_token": paymentKey]
//        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//        do {
//            request.httpBody = jsonData
//            let task = URLSession.shared.dataTask(with: (request as URLRequest)) { (data, response, error) in
//                DispatchQueue.main.async {
//                    completionHandler(data, response, error)
//                }
//            }
//            task.resume()
//        }
//    }
    
    /**
    they call the appropiate delegate methods
    */
    func handleUserDidCancel() {
        delegate?.userDidCancel()
    }
    func handlePaymentAttemptFailed(_ error: AcceptSDKError, detailedDescription: String) {
        delegate?.paymentAttemptFailed(error, detailedDescription: detailedDescription)
    }
    func handleTransactionRejected(_ payDict: [String : AnyObject]) {
        let X = DataAndTypeConverter.payDictToStruct(payDict)
        delegate?.transactionRejected(X)
    }
    func handleTransactionAccepted(_ payDict: [String : AnyObject]) {
        let X = DataAndTypeConverter.payDictToStruct(payDict)
        delegate?.transactionAccepted(X)
    }
//    func handleTransactionAccepted(_ payDict: [String : AnyObject], savedCardDict: [String : AnyObject]) {
//        let X = DataAndTypeConverter.payDictToStruct(payDict)
//        let Y = DataAndTypeConverter.saveCardDictToStruct(savedCardDict)
//        delegate?.transactionAccepted(X, savedCardData: Y)
//    }
//    func handleUserDidCancel3dSecurePayment(_ pendingPayDict: [String : AnyObject]) {
//        let X = DataAndTypeConverter.payDictToStruct(pendingPayDict)
//        delegate?.userDidCancel3dSecurePayment(X)
//    }

}
