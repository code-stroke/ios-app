//
//  ApiResponseLogin.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 01/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation

// API Fields
fileprivate let API_RESP_LOGIN_STATUS       = "status"
fileprivate let API_RESP_LOGIN_MESSAGE      = "message"
fileprivate let API_RESP_LOGIN_USER_ID      = "login_user_id"
fileprivate let API_RESP_LOGIN_DATA         = "data"

class ApiResponseLogin: ApiResponseBase {
    
    // Vars
    var status: Int                         = 0
    var message: String                     = ""
    var login_user_id: Int                  = 0
    var data: [UserIdList]                  = []
   
    convenience init?(dict: NSDictionary?) {
        do {
            let extractor = try ResponseExtractor(dict: dict)
             
            // Init
            self.init()
            
            // Base
            if let status = extractor.intValue(for: API_RESP_LOGIN_STATUS) {
                self.status = status
            }
            
            if self.status == 200 {
                self.success = true
            }
            
            // Login UserID
            guard let login_user_id = extractor.intValue(for: API_RESP_LOGIN_USER_ID) else {
                return
            }
            self.login_user_id = login_user_id
            
            // Login Message
            guard let message = extractor.stringValue(for: API_RESP_LOGIN_MESSAGE) else {
                return
            }
            self.message = message
            
            self.failureReason = FailureReason(rawValue: extractor.stringValue(for: API_FAILURE) ?? "none")
            self.responseAction = ResponseAction(rawValue: extractor.stringValue(for: API_ACTION) ?? "none")
            
            // List Of UserID
            if let userIdArray = extractor.value(for: API_RESP_LOGIN_DATA) as? [NSDictionary] {
                userIdArray.forEach({ userIdDict in
                    if let userID = UserIdList(dict: userIdDict) {
                        self.data.append(userID)
                    }
                })
            }
            
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}
