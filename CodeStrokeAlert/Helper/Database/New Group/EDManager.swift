//
//  EDManager.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 18/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation

class EDManager {
    
    /// Hide unwanted init function
    private init() {}
    
    // MARK: Manage ED
    ///
    /// Add passed ED array to Database
    /// - parameter eds: An array of ED objects that will be added to Database
    class func add(eds: [EDInfo]) {
        
        /// Check if eds is empty
        guard eds.count > 0 else {
            Log.debug(message: "Can't add passed eds array to Database. Reason: \"Passed EDInfo array is empty\".", event: .emptyArray)
            return
        }
        
        /// Remove duplicates
        let ed = eds.filter({ currentED in
            return DatabaseProvider.object(type: EDInfo.self, primaryKey: currentED.case_id
                ) == nil
        })
        
        /// Add object to Database
        DatabaseProvider.write {
            DatabaseProvider.add(ed)
        }
    }
    
    /// Update all passed ED objects
    /// - parameter cases: Array of Case objects to be updated
    class func update(eds: [EDInfo]) {
        
        /// Update objects in Database
        DatabaseProvider.write {
            DatabaseProvider.add(eds, update: true)
        }
    }
    
    /// Remove passed EDInfo array from Database
    /// - parameter eds: The array of EDInfo objects that will be deleted from Database
    class func remove(eds: [EDInfo]) {
        
        /// Check if eds is empty
        guard eds.count > 0 else {
            Log.debug(message: "Can't delete passed EDInfo array from Database. Reason: \"Passed EDInfo array is empty\".", event: .emptyArray)
            return
        }
        
        /// Delete object from Database
        DatabaseProvider.write {
            DatabaseProvider.delete(eds)
        }
    }
}
