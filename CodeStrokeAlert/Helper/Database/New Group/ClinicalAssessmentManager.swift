//
//  ClinicalAssessmentManager.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 18/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation

class ClinicalAssessmentManager {
    
    /// Hide unwanted init function
    private init() {}
    
    // MARK: Manage ClinicalAssessmentInfo
    ///
    /// Add passed ClinicalAssessmentInfo array to Database
    /// - parameter clAssessmentInfo: An array of ClinicalAssessmentInfo objects that will be added to Database
    class func add(clAssessmentInfo: [ClinicalAssessmentInfo]) {
        
        /// Check if clAssessmentInfo is empty
        guard clAssessmentInfo.count > 0 else {
            Log.debug(message: "Can't add passed clAssessmentInfo array to Database. Reason: \"Passed ClinicalInfo array is empty\".", event: .emptyArray)
            return
        }
        
        /// Remove duplicates
        let clinicalAssessment = clAssessmentInfo.filter({ currentAssessInfo in
            return DatabaseProvider.object(type: ClinicalAssessmentInfo.self, primaryKey: currentAssessInfo.case_id
                ) == nil
        })
        
        /// Add object to Database
        DatabaseProvider.write {
            DatabaseProvider.add(clinicalAssessment)
        }
    }
    
    /// Update all passed ClinicalAssessmentInfo objects
    /// - parameter clAssessmentInfo: Array of ClinicalAssessmentInfo objects to be updated
    class func update(clAssessmentInfo: [ClinicalAssessmentInfo]) {
        
        /// Update objects in Database
        DatabaseProvider.write {
            DatabaseProvider.add(clAssessmentInfo, update: true)
        }
    }
    
    /// Remove passed ClinicalAssessmentInfo array from Database
    /// - parameter clAssessmentInfo: The array of ClinicalAssessmentInfo objects that will be deleted from Database
    class func remove(clAssessmentInfo: [ClinicalAssessmentInfo]) {
        
        /// Check if clAssessmentInfo is empty
        guard clAssessmentInfo.count > 0 else {
            Log.debug(message: "Can't delete passed ClinicalAssessmentInfo array from Database. Reason: \"Passed ClinicalAssessmentInfo array is empty\".", event: .emptyArray)
            return
        }
        
        /// Delete object from Database
        DatabaseProvider.write {
            DatabaseProvider.delete(clAssessmentInfo)
        }
    }
}
