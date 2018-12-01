//
//  ClinicalInfoManager.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 18/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation

class ClinicalInfoManager {
    
    /// Hide unwanted init function
    private init() {}
    
    // MARK: Manage ClinicalInfo
    ///
    /// Add passed ClinicalInfo array to Database
    /// - parameter clInfo: An array of ClinicalInfo objects that will be added to Database
    class func add(clInfo: [ClinicalInfo]) {
        
        /// Check if clInfo is empty
        guard clInfo.count > 0 else {
            Log.debug(message: "Can't add passed eds array to Database. Reason: \"Passed ClinicalInfo array is empty\".", event: .emptyArray)
            return
        }
        
        /// Remove duplicates
        let clinical = clInfo.filter({ currentInfo in
            return DatabaseProvider.object(type: ClinicalInfo.self, primaryKey: currentInfo.case_id
                ) == nil
        })
        
        /// Add object to Database
        DatabaseProvider.write {
            DatabaseProvider.add(clinical)
        }
    }
    
    /// Update all passed ClinicalInfo objects
    /// - parameter clInfo: Array of ClinicalInfo objects to be updated
    class func update(clInfo: [ClinicalInfo]) {
        
        /// Update objects in Database
        DatabaseProvider.write {
            DatabaseProvider.add(clInfo, update: true)
        }
    }
    
    /// Remove passed ClinicalInfo array from Database
    /// - parameter clInfo: The array of ClinicalInfo objects that will be deleted from Database
    class func remove(clInfo: [ClinicalInfo]) {
        
        /// Check if clInfo is empty
        guard clInfo.count > 0 else {
            Log.debug(message: "Can't delete passed ClinicalInfo array from Database. Reason: \"Passed ClinicalInfo array is empty\".", event: .emptyArray)
            return
        }
        
        /// Delete object from Database
        DatabaseProvider.write {
            DatabaseProvider.delete(clInfo)
        }
    }
}
