//
//  ApiResponseEDInfo.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 18/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation

// API Fields
fileprivate let API_RESP_ED_SUCCESS      = "success"
fileprivate let API_RESP_ED_DESTINATION  = "destination"
fileprivate let API_RESP_ED_DEBUGMSG     = "debugmsg"
fileprivate let API_RESP_ED_ERRORTYPE    = "error_type"
fileprivate let API_RESP_ED_RESULT       = "result"

class ApiResponseEDInfo: ApiResponseBase {
    
    // Vars
    var edArray: [EDInfo]        = []
    
    convenience init?(dict: NSDictionary?) {
        do {
            let extractor = try ResponseExtractor(dict: dict)
            
            // Init
            self.init()
            
            // Base
            let status = extractor.boolValue(for: API_RESP_ED_SUCCESS)
            self.success = status
            
            if self.success {
                
                /// Cases
                if let edArr = extractor.value(for: API_RESP_ED_RESULT) as? [NSDictionary] {
                    edArr.forEach({ edDict in
                        if let currentED = EDInfo(dict: edDict) {
                            self.edArray.append(currentED)
                        }
                    })
                }
            }
            
            // Message
            let message = extractor.stringValue(for: API_RESP_ED_DESTINATION)
            self.destination = message ?? ""
            
            self.failureReason = FailureReason(rawValue: extractor.stringValue(for: API_FAILURE) ?? "none")
            self.responseAction = ResponseAction(rawValue: extractor.stringValue(for: API_ACTION) ?? "none")
            
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}

/*

 {
     "result": [
         {
         "case_id": 6,
         "location": null,
         "primary_survey": 0,
         "registered": 0,
         "triaged": 0
         }
     ],
     "success": true
 }
 
*/
