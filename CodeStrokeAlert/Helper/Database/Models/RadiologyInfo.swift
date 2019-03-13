//
//  RadiologyInfo.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 18/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

/// API Fields
fileprivate let RD_ARRIVED_TO_CT                = "arrived_to_ct"
fileprivate let RD_CASE_ID                      = "case_id"
fileprivate let RD_CT_AVAILABLE                 = "ct_available"
fileprivate let RD_CT_AVAILABLE_LOC             = "ct_available_loc"
fileprivate let RD_CT_COMPLETE                  = "ct_complete"
fileprivate let RD_CTA_CTP_COMPLETE             = "cta_ctp_complete"
fileprivate let RD_DO_CTA_CTP                   = "do_cta_ctp"
fileprivate let RD_ICH_FOUND                    = "ich_found"
fileprivate let RD_LARGE_VESSEL_OCCLUSION       = "large_vessel_occlusion"

class RadiologyInfo: Object {
    
    @objc dynamic var case_id: Int                  = 0
    @objc dynamic var ct_available: Bool            = false
    @objc dynamic var ct_available_loc: String?     = nil
    @objc dynamic var arrived_to_ct: Bool           = false
    @objc dynamic var ct_complete: Bool             = false
    @objc dynamic var ich_found: Bool               = false
    @objc dynamic var do_cta_ctp: Bool              = false
    @objc dynamic var cta_ctp_complete: Bool        = false
    @objc dynamic var large_vessel_occlusion: Bool  = false
    
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
            guard let id = extractor.intValue(for: RD_CASE_ID) else {
                Log.debug(message: "Can't find RD_CASE_ID", event: .error)
                return nil
            }
            
            // Init
            super.init()
            
            // Setting data
            self.case_id = id
            
            self.ct_available           = extractor.boolValue(for: RD_CT_AVAILABLE)
            self.ct_available_loc       = extractor.stringValue(for: RD_CT_AVAILABLE_LOC)
            self.arrived_to_ct          = extractor.boolValue(for: RD_ARRIVED_TO_CT)
            self.ct_complete            = extractor.boolValue(for: RD_CT_COMPLETE)
            self.ich_found              = extractor.boolValue(for: RD_ICH_FOUND)
            self.do_cta_ctp             = extractor.boolValue(for: RD_DO_CTA_CTP)
            self.cta_ctp_complete       = extractor.boolValue(for: RD_CTA_CTP_COMPLETE)
            self.large_vessel_occlusion = extractor.boolValue(for: RD_LARGE_VESSEL_OCCLUSION)

        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}
