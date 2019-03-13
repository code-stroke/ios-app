//
//  ManagementInfo.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 24/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

/// API Fields
fileprivate let MGMT_CASE_ID                        = "case_id"
fileprivate let MGMT_THROMBOLYSIS                   = "thrombolysis"
fileprivate let MGMT_NEW_TRAUMA_HAEMORRHAGE         = "new_trauma_haemorrhage"
fileprivate let MGMT_UNCONTROLLED_HTN               = "uncontrolled_htn"
fileprivate let MGMT_HISTORY_ICH                    = "history_ich"
fileprivate let MGMT_KNOWN_INTRACRANIAL             = "known_intracranial"
fileprivate let MGMT_ACTIVE_BLEED                   = "active_bleed"
fileprivate let MGMT_ENDOCARDITIS                   = "endocarditis"
fileprivate let MGMT_BLEEDING_DIATHESIS             = "bleeding_diathesis"
fileprivate let MGMT_ABNORMAL_BLOOD_GLUCOSE         = "abnormal_blood_glucose"
fileprivate let MGMT_RAPIDLY_IMPROVING              = "rapidly_improving"
fileprivate let MGMT_RECENT_TRAUMA_SURGERY          = "recent_trauma_surgery"
fileprivate let MGMT_RECENT_ACTIVE_BLEED            = "recent_active_bleed"
fileprivate let MGMT_SEIZURE_ONSET                  = "seizure_onset"
fileprivate let MGMT_RECENT_ARTERIAL_PUNCTURE       = "recent_arterial_puncture"
fileprivate let MGMT_RECENT_LUMBAR_PUNCTURE         = "recent_lumbar_puncture"
fileprivate let MGMT_POST_ACS_PERICARDITIS          = "post_acs_pericarditis"
fileprivate let MGMT_PREGNANT                       = "pregnant"
fileprivate let MGMT_THROMBOLYSIS_TIME_GIVEN        = "thrombolysis_time_given"
fileprivate let MGMT_ECR                            = "ecr"
fileprivate let MGMT_SURGICAL_RX                    = "surgical_rx"
fileprivate let MGMT_CONSERVATIVE_RX                = "conservative_rx"


class ManagementInfo: Object {
    
    @objc dynamic var case_id: Int                          = 0
    @objc dynamic var thrombolysis: Bool                    = false
    @objc dynamic var uncontrolled_htn: Bool                = false
    @objc dynamic var history_ich: Bool                     = false
    @objc dynamic var known_intracranial: Bool              = false
    @objc dynamic var active_bleed: Bool                    = false
    @objc dynamic var endocarditis: Bool                    = false
    @objc dynamic var bleeding_diathesis: Bool              = false
    @objc dynamic var abnormal_blood_glucose: Bool          = false
    @objc dynamic var rapidly_improving: Bool               = false
    @objc dynamic var recent_trauma_surgery: Bool           = false
    @objc dynamic var recent_active_bleed: Bool             = false
    @objc dynamic var seizure_onset: Bool                   = false
    @objc dynamic var recent_arterial_puncture: Bool        = false
    @objc dynamic var recent_lumbar_puncture: Bool          = false
    @objc dynamic var post_acs_pericarditis: Bool           = false
    @objc dynamic var pregnant: Bool                        = false
    @objc dynamic var thrombolysis_time_given: String?      = nil
    @objc dynamic var ecr: Bool                             = false
    @objc dynamic var surgical_rx: Bool                     = false
    @objc dynamic var conservative_rx: Bool                 = false

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
            guard let id = extractor.intValue(for: MGMT_CASE_ID) else {
                Log.debug(message: "Can't find MGMT_CASE_ID", event: .error)
                return nil
            }
            
            // Init
            super.init()
            
            // Setting data
            self.case_id = id
            
            self.thrombolysis                       = extractor.boolValue(for: MGMT_THROMBOLYSIS)
            self.uncontrolled_htn                   = extractor.boolValue(for: MGMT_UNCONTROLLED_HTN)
            self.history_ich                        = extractor.boolValue(for: MGMT_HISTORY_ICH)
            self.known_intracranial                 = extractor.boolValue(for: MGMT_KNOWN_INTRACRANIAL)
            self.active_bleed                       = extractor.boolValue(for: MGMT_ACTIVE_BLEED)
            self.endocarditis                       = extractor.boolValue(for: MGMT_ENDOCARDITIS)
            self.bleeding_diathesis                 = extractor.boolValue(for: MGMT_BLEEDING_DIATHESIS)
            self.abnormal_blood_glucose             = extractor.boolValue(for: MGMT_ABNORMAL_BLOOD_GLUCOSE)
            self.rapidly_improving                  = extractor.boolValue(for: MGMT_RAPIDLY_IMPROVING)
            self.recent_trauma_surgery              = extractor.boolValue(for: MGMT_RECENT_TRAUMA_SURGERY)
            self.recent_active_bleed                = extractor.boolValue(for: MGMT_RECENT_ACTIVE_BLEED)
            self.seizure_onset                      = extractor.boolValue(for: MGMT_SEIZURE_ONSET)
            self.recent_arterial_puncture           = extractor.boolValue(for: MGMT_RECENT_ARTERIAL_PUNCTURE)
            self.recent_lumbar_puncture             = extractor.boolValue(for: MGMT_RECENT_LUMBAR_PUNCTURE)
            self.post_acs_pericarditis              = extractor.boolValue(for: MGMT_POST_ACS_PERICARDITIS)
            self.pregnant                           = extractor.boolValue(for: MGMT_PREGNANT)
            self.thrombolysis_time_given            = extractor.stringValue(for: MGMT_THROMBOLYSIS_TIME_GIVEN)
            self.ecr                                = extractor.boolValue(for: MGMT_ECR)
            self.surgical_rx                        = extractor.boolValue(for: MGMT_SURGICAL_RX)
            self.conservative_rx                    = extractor.boolValue(for: MGMT_CONSERVATIVE_RX)
            
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}
