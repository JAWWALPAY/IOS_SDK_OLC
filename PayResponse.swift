//
//  PayResponse.swift
//  AcceptSDK
//
//  Created by Mohamed A Tawfik on Aug/13/17.
//  Copyright © 2017 mahmoud gamal. All rights reserved.
//

import Foundation

public struct PayResponse {
    public let amount_cents: Int
    public let is_refunded: Bool
    public let is_capture: Bool
    public let captured_amount: Int
    public let source_data_type: String
    public let pending: Bool
    public let is_3d_secure: Bool
    public let id: Int
    public let is_void: Bool
    public let currency: String
    public let is_auth: Bool
    public let is_refund: Bool
    public let owner: Int
    public let is_voided: Bool
    public let source_data_pan: String
    public let profile_id: Int
    public let success: Bool
    public let dataMessage: String
    public let source_data_sub_type: String
    public let error_occured: Bool
    public let is_standalone_payment: Bool
    public let created_at: String
    public let refunded_amount_cents: Int
    public let integration_id: Int
    public let order: Int
    
    init(amount_cents: Int, is_refunded: Bool, is_capture: Bool, captured_amount: Int, source_data_type: String, pending: Bool, is_3d_secure: Bool, id: Int, is_void: Bool, currency: String, is_auth: Bool, is_refund: Bool, owner: Int, is_voided: Bool, source_data_pan: String, profile_id: Int, success: Bool, dataMessage: String, source_data_sub_type: String, error_occured: Bool, is_standalone_payment: Bool, created_at: String, refunded_amount_cents: Int, integration_id: Int, order: Int) {
        self.amount_cents = amount_cents
        self.is_refunded = is_refunded
        self.is_capture = is_capture
        self.captured_amount = captured_amount
        self.source_data_type = source_data_type
        self.pending = pending
        self.is_3d_secure = is_3d_secure
        self.id = id
        self.is_void = is_void
        self.currency = currency
        self.is_auth = is_auth
        self.is_refund = is_refund
        self.owner = owner
        self.is_voided = is_voided
        self.source_data_pan = source_data_pan
        self.profile_id = profile_id
        self.success = success
        self.dataMessage = dataMessage
        self.source_data_sub_type = source_data_sub_type
        self.error_occured = error_occured
        self.is_standalone_payment = is_standalone_payment
        self.created_at = created_at
        self.refunded_amount_cents = refunded_amount_cents
        self.integration_id = integration_id
        self.order = order
    }
}
