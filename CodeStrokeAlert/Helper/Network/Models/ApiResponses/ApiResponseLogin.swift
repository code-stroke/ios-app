//
//  ApiResponseLogin.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 01/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation

// API Fields
fileprivate let API_RESP_LOGIN_SUCCESS      = "success"
fileprivate let API_RESP_LOGIN_DESTINATION  = "destination"
fileprivate let API_RESP_LOGIN_DEBUGMSG     = "debugmsg"
fileprivate let API_RESP_LOGIN_ERRORTYPE    = "error_type"
fileprivate let API_RESP_LOGIN_USERINFO     = "user_info"

class ApiResponseLogin: ApiResponseBase {
    
    // Vars
    var userInfo: UserInfo!
    
    convenience init?(dict: NSDictionary?) {
        do {
            let extractor = try ResponseExtractor(dict: dict)
             
            // Init
            self.init()
            
            // Base
            let status = extractor.boolValue(for: API_RESP_LOGIN_SUCCESS)
            self.success = status
            
            if self.success {
                
                /// Account
                guard let userDict = extractor.dictValue(for: API_RESP_LOGIN_USERINFO), let userInfo = UserInfo(dict: userDict) else { return }
                self.userInfo = userInfo
            }
            // Login Message
            let message = extractor.stringValue(for: API_RESP_LOGIN_DESTINATION)
            self.destination = message ?? ""
            
            self.failureReason = FailureReason(rawValue: extractor.stringValue(for: API_FAILURE) ?? "none")
            self.responseAction = ResponseAction(rawValue: extractor.stringValue(for: API_ACTION) ?? "none")
            
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}
