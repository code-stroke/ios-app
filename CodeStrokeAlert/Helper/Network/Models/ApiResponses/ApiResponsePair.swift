//
//  ApiResponsePair.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 10/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation

// API Fields
fileprivate let API_RESP_LOGIN_SUCCESS      = "success"
fileprivate let API_RESP_LOGIN_DESTINATION  = "destination"
fileprivate let API_RESP_LOGIN_DEBUGMSG     = "debugmsg"
fileprivate let API_RESP_LOGIN_ERRORTYPE    = "error_type"
fileprivate let API_RESP_SHARED_SECRET      = "shared_secret"
fileprivate let API_RESP_TOKEN              = "token"

class ApiResponsePair: ApiResponseBase {
    
    var token: String                       = ""
    var shared_secret: String               = ""
    
    convenience init?(dict: NSDictionary?) {
        do {
            let extractor = try ResponseExtractor(dict: dict)
            
            // Init
            self.init()
            
            // Base
            let status = extractor.boolValue(for: API_RESP_LOGIN_SUCCESS)
            self.success = status
            
            if self.success {
                
                let secret = extractor.stringValue(for: API_RESP_SHARED_SECRET)
                self.shared_secret = secret ?? ""
                
                let token = extractor.stringValue(for: API_RESP_TOKEN)
                self.token = token ?? ""
            }
            
            // Login Message
            let message = extractor.stringValue(for: API_RESP_LOGIN_DEBUGMSG)
            self.destination = message ?? ""
            
            self.failureReason = FailureReason(rawValue: extractor.stringValue(for: API_FAILURE) ?? "none")
            self.responseAction = ResponseAction(rawValue: extractor.stringValue(for: API_ACTION) ?? "none")
            
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}

