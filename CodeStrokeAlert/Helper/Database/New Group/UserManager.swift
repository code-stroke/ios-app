//
//  UserManager.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 29/09/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import RxSwift

// UserDefaults fields
fileprivate let ACTIVE_USER_ID = "ActiveUserId"

class UserManager {
    
    // Hide unwanted init function
    private init() {}
    
    
    
    // MARK: Manage Users
    // Add passed User to Database
    // - Parameter UserIdList: The Users that will be added to Database

    class func addUserIDs(users: [UserIdList]?) {
        
        // Check if UserIdList is nil
        guard let users = users else {
            Log.debug(message: "Can't add passed UserId to Database. Reason: \"Passed UserIdList is 'nil'\"", event: .nullPointer)
            return
        }
        
        // Add object to Database
        DatabaseProvider.write {
            users.forEach({ user in
                DatabaseProvider.add(user, update: true)
            })
        }
    }
}
