//
//  ApiResponseCaseList.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 17/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation

// API Fields
fileprivate let API_RESP_CASE_SUCCESS      = "success"
fileprivate let API_RESP_CASE_DESTINATION  = "destination"
fileprivate let API_RESP_CASE_DEBUGMSG     = "debugmsg"
fileprivate let API_RESP_CASE_ERRORTYPE    = "error_type"
fileprivate let API_RESP_CASE_RESULT       = "result"

class ApiResponseCaseList: ApiResponseBase {
    
    // Vars
    var caseArray: [Case]        = []
    
    convenience init?(dict: NSDictionary?) {
        do {
            let extractor = try ResponseExtractor(dict: dict)
            
            // Init
            self.init()
            
            // Base
            let status = extractor.boolValue(for: API_RESP_CASE_SUCCESS)
            self.success = status
            
            if self.success {
                
                /// Cases
                if let casesArray = extractor.value(for: API_RESP_CASE_RESULT) as? [NSDictionary] {
                    casesArray.forEach({ caseDict in
                        if let currentCase = Case(dict: caseDict) {
                            self.caseArray.append(currentCase)
                        }
                    })
                }
            }
            
            // Message
            let message = extractor.stringValue(for: API_RESP_CASE_DESTINATION)
            self.destination = message ?? ""
            
            self.failureReason = FailureReason(rawValue: extractor.stringValue(for: API_FAILURE) ?? "none")
            self.responseAction = ResponseAction(rawValue: extractor.stringValue(for: API_ACTION) ?? "none")
            
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}
