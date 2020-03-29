//
//  SaveCardResponse.swift
//  AcceptSDK
//
//  Created by Mohamed A Tawfik on Aug/13/17.
//  Copyright © 2017 mahmoud gamal. All rights reserved.
//

import Foundation

public struct SaveCardResponse {
    public let card_subtype: String
    public let id: Int
    public let token: String
    public let created_at: String
    public let masked_pan: String
    public let merchant_id: Int
    public let order_id: Int?
    public let email: String?
    
    init(card_subtype: String, id: Int, token: String, created_at: String, masked_pan: String, merchant_id: Int, order_id: Int? = nil, email: String? = nil) {
        self.card_subtype = card_subtype
        self.id = id
        self.token = token
        self.created_at = created_at
        self.masked_pan = masked_pan
        self.merchant_id = merchant_id
        self.order_id = order_id
        self.email = email
    }
}

