//
//  AcceptSDKError.swift
//  AcceptSDK
//
//  Created by Mohamed A Tawfik on Aug/6/17.
//  Copyright © 2017 mahmoud gamal. All rights reserved.
//

import Foundation

public enum AcceptSDKError : Error {
    case MissingArgumentError(String)
    case ServerError(String)
    case JSONParsingError(String)
    case Unknown(String)
}
