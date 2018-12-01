//
//  ClinicalAssessmentInfo.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 18/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

/// API Fields
fileprivate let CLA_APHASIA             = "aphasia"
fileprivate let CLA_ARM_DRIFT           = "arm_drift"
fileprivate let CLA_ARM_MOTER_IMPAIR    = "arm_motor_impair"
fileprivate let CLA_BLINK_SQUEEZE       = "blink_squeeze"
fileprivate let CLA_BLOOD_GLUCOSE       = "blood_glucose"
fileprivate let CLA_BP_DIASTOLIC        = "bp_diastolic"
fileprivate let CLA_BP_SYSTOLIC         = "bp_systolic"
fileprivate let CLA_CANNULA             = "cannula"
fileprivate let CLA_CASE_ID             = "case_id"
fileprivate let CLA_CONSCIOUS_LEVEL     = "conscious_level"
fileprivate let CLA_DYSARTHRIA          = "dysarthria"
fileprivate let CLA_FACIAL_DROOP        = "facial_droop"
fileprivate let CLA_FACIAL_PALSY_NIHSS  = "facial_palsy_nihss"
fileprivate let CLA_FACIAL_PALSY_RACE   = "facial_palsy_race"
fileprivate let CLA_GCS                 = "gcs"
fileprivate let CLA_HEAD_GAZE_DEVIATE   = "head_gaze_deviate"
fileprivate let CLA_HEART_RATE          = "heart_rate"
fileprivate let CLA_HEART_RHYTHM        = "heart_rhythm"
fileprivate let CLA_HEMIPARESIS         = "hemiparesis"
fileprivate let CLA_HORIZONTAL_GAZE     = "horizontal_gaze"
fileprivate let CLA_LEFT_ARM_DRIFT      = "left_arm_drift"
fileprivate let CLA_LEFT_LEG_DRIFT      = "left_leg_drift"
fileprivate let CLA_LEG_MOTOR_IMPAIR    = "leg_motor_impair"
fileprivate let CLA_LIKELY_LVO          = "likely_lvo"
fileprivate let CLA_LIMB_ATAXIA         = "limb_ataxia"
fileprivate let CLA_MONTH_AGE           = "month_age"
fileprivate let CLA_NEGLECT             = "neglect"
fileprivate let CLA_O2SATS              = "o2sats"
fileprivate let CLA_RANKIN_CONSCIOUS    = "rankin_conscious"
fileprivate let CLA_RIGHT_ARM_DRIFT     = "right_arm_drift"
fileprivate let CLA_RIGHT_LEG_DRIFT     = "right_leg_drift"
fileprivate let CLA_RR                  = "rr"
fileprivate let CLA_SENSATION           = "sensation"
fileprivate let CLA_SPEECH_DIFFICULTY   = "speech_difficulty"
fileprivate let CLA_TEMP                = "temp"
fileprivate let CLA_VISUAL_FIELDS       = "visual_fields"
fileprivate let CLA_WEAK_GRIP           = "weak_grip"

class ClinicalAssessmentInfo: Object {
    
    @objc dynamic var aphasia: Int                  = 0
    @objc dynamic var arm_drift: String?            = nil
    @objc dynamic var arm_motor_impair: Int         = 0
    @objc dynamic var blink_squeeze: Int            = 0
    @objc dynamic var blood_glucose: Int            = 0
    @objc dynamic var bp_diastolic: Int             = 0
    @objc dynamic var bp_systolic: Int              = 0
    @objc dynamic var cannula: String?              = nil
    @objc dynamic var case_id: Int                  = 0
    @objc dynamic var conscious_level: Int          = 0
    @objc dynamic var dysarthria: Int               = 0
    @objc dynamic var facial_droop: String?         = nil
    @objc dynamic var facial_palsy_nihss: Int       = 0
    @objc dynamic var facial_palsy_race: Int        = 0
    @objc dynamic var gcs: Int                      = 0
    @objc dynamic var head_gaze_deviate: Int        = 0
    @objc dynamic var heart_rate: Int               = 0
    @objc dynamic var heart_rhythm: String?         = nil
    @objc dynamic var hemiparesis: String?          = nil
    @objc dynamic var horizontal_gaze: Int          = 0
    @objc dynamic var left_arm_drift: Int           = 0
    @objc dynamic var left_leg_drift: Int           = 0
    @objc dynamic var leg_motor_impair: Int         = 0
    @objc dynamic var likely_lvo: Bool              = false
    @objc dynamic var limb_ataxia: Int              = 0
    @objc dynamic var month_age: Int                = 0
    @objc dynamic var neglect: Int                  = 0
    @objc dynamic var o2sats: Int                   = 0
    @objc dynamic var rankin_conscious: Int         = 0
    @objc dynamic var right_arm_drift: Int          = 0
    @objc dynamic var right_leg_drift: Int          = 0
    @objc dynamic var rr: Int                       = 0
    @objc dynamic var sensation: Int                = 0
    @objc dynamic var speech_difficulty: String?    = nil
    @objc dynamic var temp: Int                     = 0
    @objc dynamic var visual_fields: Int            = 0
    @objc dynamic var weak_grip: String?            = nil
    
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
            guard let id = extractor.intValue(for: CLA_CASE_ID) else {
                Log.debug(message: "Can't find CLA_CASE_ID", event: .error)
                return nil
            }
            
            // Init
            super.init()
            
            // Setting data
            self.case_id = id
            
            if let aphasia = extractor.intValue(for: CLA_APHASIA) {
                self.aphasia = aphasia
            }
            
            self.arm_drift = extractor.stringValue(for: CLA_ARM_DRIFT)
            
            if let arm_motor_impair = extractor.intValue(for: CLA_ARM_MOTER_IMPAIR) {
                self.arm_motor_impair = arm_motor_impair
            }
            
            if let blink_squeeze = extractor.intValue(for: CLA_BLINK_SQUEEZE) {
                self.blink_squeeze = blink_squeeze
            }
            
            if let blood_glucose = extractor.intValue(for: CLA_BLOOD_GLUCOSE) {
                self.blood_glucose = blood_glucose
            }
            
            if let bp_diastolic = extractor.intValue(for: CLA_BP_DIASTOLIC) {
                self.bp_diastolic = bp_diastolic
            }
            
            if let bp_systolic = extractor.intValue(for: CLA_BP_SYSTOLIC) {
                self.bp_systolic = bp_systolic
            }
            
            self.cannula = extractor.stringValue(for: CLA_CANNULA)
            
            if let conscious_level = extractor.intValue(for: CLA_CONSCIOUS_LEVEL) {
                self.conscious_level = conscious_level
            }
            
            if let dysarthria = extractor.intValue(for: CLA_DYSARTHRIA) {
                self.dysarthria = dysarthria
            }
            
            self.facial_droop = extractor.stringValue(for: CLA_FACIAL_DROOP)
            
            if let facial_palsy_nihss = extractor.intValue(for: CLA_FACIAL_PALSY_NIHSS) {
                self.facial_palsy_nihss = facial_palsy_nihss
            }
            
            if let facial_palsy_race = extractor.intValue(for: CLA_FACIAL_PALSY_RACE) {
                self.facial_palsy_race = facial_palsy_race
            }
            
            if let facial_palsy_race = extractor.intValue(for: CLA_FACIAL_PALSY_RACE) {
                self.facial_palsy_race = facial_palsy_race
            }
            
            if let gcs = extractor.intValue(for: CLA_GCS) {
                self.gcs = gcs
            }
            
            if let head_gaze_deviate = extractor.intValue(for: CLA_HEAD_GAZE_DEVIATE) {
                self.head_gaze_deviate = head_gaze_deviate
            }

            if let heart_rate = extractor.intValue(for: CLA_HEART_RATE) {
                self.heart_rate = heart_rate
            }
            
            self.heart_rhythm = extractor.stringValue(for: CLA_HEART_RHYTHM)
            self.hemiparesis = extractor.stringValue(for: CLA_HEMIPARESIS)

            if let horizontal_gaze = extractor.intValue(for: CLA_HORIZONTAL_GAZE) {
                self.horizontal_gaze = horizontal_gaze
            }
            
            if let left_arm_drift = extractor.intValue(for: CLA_LEFT_ARM_DRIFT) {
                self.left_arm_drift = left_arm_drift
            }

            if let left_leg_drift = extractor.intValue(for: CLA_LEFT_LEG_DRIFT) {
                self.left_leg_drift = left_leg_drift
            }
            
            if let limb_ataxia = extractor.intValue(for: CLA_LIMB_ATAXIA) {
                self.limb_ataxia = limb_ataxia
            }
            
            self.likely_lvo = extractor.boolValue(for: CLA_LIKELY_LVO)

            if let month_age = extractor.intValue(for: CLA_MONTH_AGE) {
                self.month_age = month_age
            }
            
            if let neglect = extractor.intValue(for: CLA_NEGLECT) {
                self.neglect = neglect
            }
            
            if let o2sats = extractor.intValue(for: CLA_O2SATS) {
                self.o2sats = o2sats
            }
            
            if let rankin_conscious = extractor.intValue(for: CLA_CONSCIOUS_LEVEL) {
                self.rankin_conscious = rankin_conscious
            }
            
            if let right_arm_drift = extractor.intValue(for: CLA_RIGHT_ARM_DRIFT) {
                self.right_arm_drift = right_arm_drift
            }
            
            if let right_leg_drift = extractor.intValue(for: CLA_RIGHT_LEG_DRIFT) {
                self.right_leg_drift = right_leg_drift
            }
            
            if let rr = extractor.intValue(for: CLA_RR) {
                self.rr = rr
            }
            
            if let sensation = extractor.intValue(for: CLA_SENSATION) {
                self.sensation = sensation
            }
            
            self.speech_difficulty = extractor.stringValue(for: CLA_SPEECH_DIFFICULTY)
            
            if let temp = extractor.intValue(for: CLA_TEMP) {
                self.temp = temp
            }
            
            if let visual_fields = extractor.intValue(for: CLA_VISUAL_FIELDS) {
                self.visual_fields = visual_fields
            }
            
            self.weak_grip = extractor.stringValue(for: CLA_WEAK_GRIP)
            
        } catch {
            Log.debug(message: "Can't initialize ResponseExtractor. Reason: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
}
