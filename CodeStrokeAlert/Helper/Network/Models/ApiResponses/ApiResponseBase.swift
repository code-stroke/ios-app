//
//  ApiResponseBase.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 01/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation

// API Fields
internal let API_SUCCESS = "success"
internal let API_FAILURE = "failure_reason"
internal let API_ACTION  = "action"

// Failure reasons
enum FailureReason: String {
    case wrongCredentials = "wrong_credentials"
    case upgradeNeeded    = "upgrade_needed"
    case none             = "none"
}

// Response action
enum ResponseAction: String {
    case actionUpdate = "update"
    case none         = "none"
}

class ApiResponseBase {
    var success: Bool = false
    var failureReason: FailureReason? = nil
    var responseAction: ResponseAction? = nil
}
