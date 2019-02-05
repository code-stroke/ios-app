//
//  UserIdList.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 01/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

// API Fields
fileprivate let USER_ID         = "login_user_id"

class UserIdList: Object {
    
    @objc dynamic var user_id: Int = 0
    
    override static func primaryKey() -> String? {
        return "login_user_id"
    }
    
    // Hide unwanted initialiser
    @available(*, unavailable)
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    @available(*, unavailable)
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    @available(*, unavailable)
    required init() {
        super.init()
    }
    
    init?(dict: NSDictionary?) {
        do {
            let extractor = try ResponseExtractor(dict: dict)
            
            // Check for id, latitude and longitude
            guard let id = extractor.intValue(for: USER_ID) else { return nil }
            
            // Init
            super.init()
            
            // Setting data
            self.user_id = id
            
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}
