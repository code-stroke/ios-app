//
//  ApiResponseClinicalAssessmentInfo.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 18/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation

// API Fields
fileprivate let API_RESP_CL_SUCCESS      = "success"
fileprivate let API_RESP_CL_DESTINATION  = "destination"
fileprivate let API_RESP_CL_DEBUGMSG     = "debugmsg"
fileprivate let API_RESP_CL_ERRORTYPE    = "error_type"
fileprivate let API_RESP_CL_RESULT       = "result"

class ApiResponseClinicalAssessmentInfo: ApiResponseBase {
    
    // Vars
    var clinicalInfoArray: [ClinicalInfo]        = []
    
    convenience init?(dict: NSDictionary?) {
        do {
            let extractor = try ResponseExtractor(dict: dict)
            
            // Init
            self.init()
            
            // Base
            let status = extractor.boolValue(for: API_RESP_CL_SUCCESS)
            self.success = status
            
            if self.success {
                
                /// Cases
                if let clArr = extractor.value(for: API_RESP_CL_RESULT) as? [NSDictionary] {
                    clArr.forEach({ clDict in
                        if let currentCLInfo = ClinicalInfo(dict: clDict) {
                            self.clinicalInfoArray.append(currentCLInfo)
                        }
                    })
                }
            }
            
            // Message
            let message = extractor.stringValue(for: API_RESP_CL_DESTINATION)
            self.destination = message ?? ""
            
            self.failureReason = FailureReason(rawValue: extractor.stringValue(for: API_FAILURE) ?? "none")
            self.responseAction = ResponseAction(rawValue: extractor.stringValue(for: API_ACTION) ?? "none")
            
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}
