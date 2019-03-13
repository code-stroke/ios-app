//
//  ClinicalInfo.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 18/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

/// API Fields
fileprivate let CL_ANTICOAGS                = "anticoags"
fileprivate let CL_ANTICOAGS_LAST_DOSE      = "anticoags_last_dose"
fileprivate let CL_CASE_ID                  = "case_id"
fileprivate let CL_HOPC                     = "hopc"
fileprivate let CL_LAST_MEAL                = "last_meal"
fileprivate let CL_MEDS                     = "meds"
fileprivate let CL_PMHX                     = "pmhx"
fileprivate let CL_WEIGHT                   = "weight"

class ClinicalInfo: Object {
    
    @objc dynamic var anticoags: String?            = nil
    @objc dynamic var case_id: Int                  = 0
    @objc dynamic var anticoags_last_dose: String?  = nil
    @objc dynamic var hopc: String?                 = nil
    @objc dynamic var last_meal: String?            = nil
    @objc dynamic var meds: String?                 = nil
    @objc dynamic var pmhx: String?                 = nil
    @objc dynamic var weight: Float                 = 0.0
    
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
            guard let id = extractor.intValue(for: CL_CASE_ID) else {
                Log.debug(message: "Can't find CL_CASE_ID", event: .error)
                return nil
            }
            
            // Init
            super.init()
            
            // Setting data
            self.case_id = id
            self.anticoags = extractor.stringValue(for: CL_ANTICOAGS)
            self.anticoags_last_dose = extractor.stringValue(for: CL_ANTICOAGS_LAST_DOSE)
            self.hopc = extractor.stringValue(for: CL_HOPC)
            self.last_meal = extractor.stringValue(for: CL_LAST_MEAL)
            self.meds = extractor.stringValue(for: CL_MEDS)
            self.pmhx = extractor.stringValue(for: CL_PMHX)
            self.weight = extractor.floatValue(for: CL_WEIGHT) ?? 0.0
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}
