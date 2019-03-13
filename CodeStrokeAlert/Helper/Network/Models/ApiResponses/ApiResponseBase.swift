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
internal let API_FAILURE = "debugmsg"
internal let API_ACTION  = "action"
internal let API_CASEID  = "case_id"

// Failure reasons
enum FailureReason: String {
    case wrongCredentials       = "wrong_credentials"
    case userNameAlreadyTaken   = "Username is already taken."
    case notPassParam           = "Input parameters did not pass"
    case none                   = "none"
}

// Response action
enum ResponseAction: String {
    case actionUpdate                       = "update"
    case none                               = "none"
}

class ApiResponseBase {
    
    var success: Bool                       = false
    var failureReason: FailureReason?       = nil
    var responseAction: ResponseAction?     = nil
    
    var destination: String                 = ""
    var debugMsg: String                    = ""
    var errorType: String                   = ""
    
    convenience init?(dict: NSDictionary?) {
        do {
            let extractor = try ResponseExtractor(dict: dict)
            
            // Init
            self.init()
            
            // Base
            let status = extractor.boolValue(for: API_SUCCESS)
            self.success = status

            // Message
            let message = extractor.stringValue(for: API_FAILURE)
            self.destination = message ?? ""
            
            self.failureReason = FailureReason(rawValue: extractor.stringValue(for: API_FAILURE) ?? "none")
            self.responseAction = ResponseAction(rawValue: extractor.stringValue(for: API_ACTION) ?? "none")
            
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}


class ApiResponseAddCase {
    
    var success: Bool                       = false
    var caseId: Int                         = 0
    var failureReason: FailureReason?       = nil
    var responseAction: ResponseAction?     = nil
    
    var destination: String                 = ""
    var debugMsg: String                    = ""
    var errorType: String                   = ""
    
    convenience init?(dict: NSDictionary?) {
        do {
            let extractor = try ResponseExtractor(dict: dict)
            
            // Init
            self.init()
            
            // Base
            let status = extractor.boolValue(for: API_SUCCESS)
            self.success = status
            
            // Message
            let message = extractor.stringValue(for: API_FAILURE)
            self.destination = message ?? ""
            
            // Case ID
            if let caseID = extractor.intValue(for: API_CASEID) {
                self.caseId = caseID
            }
            
            self.failureReason = FailureReason(rawValue: extractor.stringValue(for: API_FAILURE) ?? "none")
            self.responseAction = ResponseAction(rawValue: extractor.stringValue(for: API_ACTION) ?? "none")
            
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}
