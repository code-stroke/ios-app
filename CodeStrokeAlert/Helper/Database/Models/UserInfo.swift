//
//  UserInfo.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 17/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

/// API Fields
fileprivate let UI_FIRSTNAME        = "signoff_first_name"
fileprivate let UI_LASTNAME         = "signoff_last_name"
fileprivate let UI_ROLE             = "signoff_role"
fileprivate let UI_USERNAME         = "signoff_username"

class UserInfo: Object {
    
    @objc dynamic var firstname: String?    = nil
    @objc dynamic var lastname: String?     = nil
    @objc dynamic var role: String?         = nil
    @objc dynamic var username: String?     = nil
    
    /// Primary-Key
    override class func primaryKey() -> String? {
        return "username"
    }
    
    /// Hide unwanted initialiser
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
        
            // Init
            super.init()
            
            // Setting data
            self.firstname  = extractor.stringValue(for: UI_FIRSTNAME)
            self.lastname   = extractor.stringValue(for: UI_LASTNAME)
            self.role       = extractor.stringValue(for: UI_ROLE)
            self.username   = extractor.stringValue(for: UI_USERNAME)
            
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}
