//
//  Case.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 17/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

/// API Fields
fileprivate let CS_ACTIVE_TIMESTAMP         = "active_timestamp"
fileprivate let CS_ADDRESS                  = "address"
fileprivate let CS_CASE_ID                  = "case_id"
fileprivate let CS_COMPLETED_TIMESTAMP      = "completed_timestamp"
fileprivate let CS_DOB                      = "dob"
fileprivate let CS_ETA                      = "eta"
fileprivate let CS_FIRST_NAME               = "first_name"
fileprivate let CS_GENDER                   = "gender"
fileprivate let CS_INCOMING_TIMESTAMP       = "incoming_timestamp"
fileprivate let CS_LAT                      = "initial_location_lat"
fileprivate let CS_LNG                      = "initial_location_long"
fileprivate let CS_LAST_NAME                = "last_name"
fileprivate let CS_LAST_WELL                = "last_well"
fileprivate let CS_MEDICARE_NO              = "medicare_no"
fileprivate let CS_NOK                      = "nok"
fileprivate let CS_NOK_PHONE                = "nok_phone"
fileprivate let CS_STATUS                   = "status"

class Case: Object {
    
    @objc dynamic var active_timestamp: String?         = nil
    @objc dynamic var address: String?                  = nil
    @objc dynamic var case_id: Int                      = 0
    @objc dynamic var completed_timestamp: String?      = nil
    @objc dynamic var dob: String?                      = nil
    @objc dynamic var eta: String?                      = nil
    @objc dynamic var first_name: String?               = nil
    @objc dynamic var gender: String?                   = nil
    @objc dynamic var incoming_timestamp: String?       = nil
    @objc dynamic var initial_location_lat: String?     = nil
    @objc dynamic var initial_location_long: String?    = nil
    @objc dynamic var last_name: String?                = nil
    @objc dynamic var last_well: String?                = nil
    @objc dynamic var medicare_no: String?              = nil
    @objc dynamic var nok: String?                      = nil
    @objc dynamic var nok_phone: String?                = nil
    @objc dynamic var status: String?                   = nil
    
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
            guard let id = extractor.intValue(for: CS_CASE_ID) else {
                Log.debug(message: "Can't find CS_CASE_ID", event: .error)
                return nil
            }
            
            // Init
            super.init()
            
            // Setting data
            self.case_id = id
            self.active_timestamp = extractor.stringValue(for: CS_ACTIVE_TIMESTAMP)
            self.address = extractor.stringValue(for: CS_ADDRESS)
            self.completed_timestamp = extractor.stringValue(for: CS_COMPLETED_TIMESTAMP)
            self.dob = extractor.stringValue(for: CS_DOB)
            self.eta = extractor.stringValue(for: CS_ETA)
            self.first_name = extractor.stringValue(for: CS_FIRST_NAME)
            self.gender = extractor.stringValue(for: CS_GENDER)
            self.incoming_timestamp = extractor.stringValue(for: CS_INCOMING_TIMESTAMP)
            self.initial_location_lat = extractor.stringValue(for: CS_LAT)
            self.initial_location_long = extractor.stringValue(for: CS_LNG)
            self.last_name = extractor.stringValue(for: CS_LAST_NAME)
            self.last_well = extractor.stringValue(for: CS_LAST_WELL)
            self.medicare_no = extractor.stringValue(for: CS_MEDICARE_NO)
            self.nok = extractor.stringValue(for: CS_NOK)
            self.nok_phone = extractor.stringValue(for: CS_NOK_PHONE)
            self.status = extractor.stringValue(for: CS_STATUS)
            
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}
