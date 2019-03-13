//
//  CasesManager.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 17/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation

class CasesManager {
    
    /// Hide unwanted init function
    private init() {}
    
    // MARK: Manage Case
    ///
    /// Add passed Case array to Database
    /// - parameter cases: An array of Case objects that will be added to Database
    class func add(cases: [Case]) {
        
        /// Check if cases is empty
        guard cases.count > 0 else {
            Log.debug(message: "Can't add passed case array to Database. Reason: \"Passed Case array is empty\".", event: .emptyArray)
            return
        }
        
        /// Remove duplicates
        let casesToAdd = cases.filter({ currentCase in
            return DatabaseProvider.object(type: Case.self, primaryKey: currentCase.case_id
                ) == nil
        })
        
        /// Add object to Database
        DatabaseProvider.write {
            DatabaseProvider.add(casesToAdd)
        }
        
    }
    
    /// Update all passed Case objects
    /// - parameter cases: Array of Case objects to be updated
    class func update(cases: [Case]) {
        
        /// Update objects in Database
        DatabaseProvider.write {
            DatabaseProvider.add(cases, update: true)
        }
    }
    
    /// Remove passed Case array from Database
    /// - parameter cases: The array of Case objects that will be deleted from Database
    class func remove(cases: [Case]) {
        
        /// Check if cases is empty
        guard cases.count > 0 else {
            Log.debug(message: "Can't delete passed Case array from Database. Reason: \"Passed Case array is empty\".", event: .emptyArray)
            return
        }
        
        /// Delete object from Database
        DatabaseProvider.write {
            DatabaseProvider.delete(cases)
        }
        
    }
}
