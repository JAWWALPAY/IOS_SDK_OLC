//
//  AcceptSDKDelegate.swift
//  AcceptSDK
//
//  Created by Mohamed A Tawfik on Aug/13/17.
//  Copyright © 2017 mahmoud gamal. All rights reserved.
//

import Foundation

public protocol AcceptSDKDelegate: class {
    /**
     This method is called when the user quits the SDK by clicking cancel
     */
    func userDidCancel()
    /**
     This method is called when the server returns an error or unknown JSON format
     */
    func paymentAttemptFailed(_ error: AcceptSDKError, detailedDescription: String)
    /**
     This method is called when the payment transaction is rejected
     */
    func transactionRejected(_ payData: PayResponse)
    /**
     This method is called when the payment transaction is accepted
     */
    func transactionAccepted(_ payData: PayResponse)
    /**
     This method is called when the payment transaction is accepted and card was successfully saved
     */
//    func transactionAccepted(_ payData: PayResponse, savedCardData: SaveCardResponse)
    /**
     This method is called when the user quits 3d secure authorization step
     */
//    func userDidCancel3dSecurePayment(_ pendingPayData: PayResponse)
}
