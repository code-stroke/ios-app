//
//  EDInfo.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 18/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

/// API Fields
fileprivate let ED_LOCATION         = "location"
fileprivate let ED_PRIMARY_SURVEY   = "primary_survey"
fileprivate let ED_CASE_ID          = "case_id"
fileprivate let ED_REGISTERED       = "registered"
fileprivate let ED_TRIAGED          = "triaged"

class EDInfo: Object {
    
    @objc dynamic var location: String?     = nil
    @objc dynamic var case_id: Int          = 0
    @objc dynamic var primary_survey: Int   = 0
    @objc dynamic var registered: Int       = 0
    @objc dynamic var triaged: Int          = 0
    
    /// Primary-Key
    override class func primaryKey() -> String? {
        return "case_id"
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
            
            /// Check if ID is not nil
            guard let id = extractor.intValue(for: ED_CASE_ID), let primary_survey = extractor.intValue(for: ED_PRIMARY_SURVEY), let registered = extractor.intValue(for: ED_REGISTERED), let triaged = extractor.intValue(for: ED_TRIAGED) else {
                Log.debug(message: "Can't find ED_CASE_ID", event: .error)
                return nil
            }
            
            // Init
            super.init()
            
            // Setting data
            self.case_id = id
            self.location = extractor.stringValue(for: ED_LOCATION)
            self.primary_survey = primary_survey
            self.registered = registered
            self.triaged = triaged
            
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}
