//
//  UserManager.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 29/09/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation

// UserDefaults fields
fileprivate let ACTIVE_USER_NAME = "ActiveUserName"

class UserManager {
    
    // Hide unwanted init function
    private init() {}
    
    // MARK: Set/Get active UserInfo
    ///
    /// Set passed UserInfo as active
    /// - parameter account: The UserInfo that will be set as active
    class func setActive(user: UserInfo?) {
        
        /// Set account as active
        UserDefaults.standard.set(user?.username, forKey: ACTIVE_USER_NAME)
    }
    
    /// Get current active UserInfo
    class var activeUser: UserInfo? {
        get {
            /// Check if username is present
            guard let activeUserName = UserDefaults.standard.value(forKey: ACTIVE_USER_NAME) as? String else { return nil }
            
            /// Read all UserInfo objects from Database and filter for ID
            return DatabaseProvider.object(type: UserInfo.self, primaryKey: activeUserName)
        }
    }
    
    // MARK: Manage Accounts
    ///
    /// Add passed UserInfo to Database
    /// - parameter user: The Account that will be added to Database
    /// - parameter shouldBeActive: Bool value to determine if the passed Account should also be setted as active automatically
    class func add(user: UserInfo?) {
        
        /// Check if user is nil
        guard let user = user else {
            Log.debug(message: "Can't add passed UserInfo to Database. Reason: \"Passed User is 'nil'\"", event: .nullPointer)
            return
        }
        
        /// Check for duplicates
        guard DatabaseProvider.object(type: UserInfo.self, primaryKey: user.username) == nil else {
            Log.debug(message: "An user with this identifier already exists!", event: .error)
            self.setActive(user: user)
            return
        }
        
        /// Add object to Database
        DatabaseProvider.write {
            DatabaseProvider.add(user)
        }

        self.setActive(user: user)
    }
    
    /// Remove passed UserInfo from Database
    /// - parameter account: The UserInfo that will be deleted from Database
    class func remove(user: UserInfo?) {
        
        /// Check if user is nil
        guard let user = user else {
            Log.debug(message: "Can't delete passed Account from Database. Reason: \"Passed Account is 'nil'\"", event: .nullPointer)
            return
        }
        
        /// If Active, deactivate account
        if user.username == self.activeUser?.username {
            self.setActive(user: user)
        }
        
        /// Delete object from Database
        DatabaseProvider.write {
            DatabaseProvider.delete(user)
        }
    }
}
