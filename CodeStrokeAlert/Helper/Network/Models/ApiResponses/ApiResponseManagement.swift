//
//  ApiResponseManagement.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 24/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation

// API Fields
fileprivate let API_RESP_RD_SUCCESS      = "success"
fileprivate let API_RESP_RD_DESTINATION  = "destination"
fileprivate let API_RESP_RD_DEBUGMSG     = "debugmsg"
fileprivate let API_RESP_RD_ERRORTYPE    = "error_type"
fileprivate let API_RESP_RD_RESULT       = "result"

class ApiResponseManagement: ApiResponseBase {
    
    // Vars
    var managementInfoArray: [ManagementInfo]        = []
    
    convenience init?(dict: NSDictionary?) {
        do {
            let extractor = try ResponseExtractor(dict: dict)
            
            // Init
            self.init()
            
            // Base
            let status = extractor.boolValue(for: API_RESP_RD_SUCCESS)
            self.success = status
            
            if self.success {
                
                /// Cases
                if let mgmtArr = extractor.value(for: API_RESP_RD_RESULT) as? [NSDictionary] {
                    mgmtArr.forEach({ mgmtDict in
                        if let currentMgmtInfo = ManagementInfo(dict: mgmtDict) {
                            self.managementInfoArray.append(currentMgmtInfo)
                        }
                    })
                }
            }
            
            // Message
            let message = extractor.stringValue(for: API_RESP_RD_DESTINATION)
            self.destination = message ?? ""
            
            self.failureReason = FailureReason(rawValue: extractor.stringValue(for: API_FAILURE) ?? "none")
            self.responseAction = ResponseAction(rawValue: extractor.stringValue(for: API_ACTION) ?? "none")
            
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}
