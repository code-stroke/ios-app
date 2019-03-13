
//
//  ApiResponseRadiology.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 23/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation

// API Fields
fileprivate let API_RESP_RD_SUCCESS      = "success"
fileprivate let API_RESP_RD_DESTINATION  = "destination"
fileprivate let API_RESP_RD_DEBUGMSG     = "debugmsg"
fileprivate let API_RESP_RD_ERRORTYPE    = "error_type"
fileprivate let API_RESP_RD_RESULT       = "result"

class ApiResponseRadiology: ApiResponseBase {
    
    // Vars
    var radiologyInfoArray: [RadiologyInfo]        = []
    
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
                if let rdArr = extractor.value(for: API_RESP_RD_RESULT) as? [NSDictionary] {
                    rdArr.forEach({ rdDict in
                        if let currentRDInfo = RadiologyInfo(dict: rdDict) {
                            self.radiologyInfoArray.append(currentRDInfo)
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
