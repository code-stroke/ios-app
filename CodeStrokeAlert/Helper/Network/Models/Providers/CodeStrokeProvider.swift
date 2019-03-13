//
//  CodeStrokeProvider.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 30/09/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import Moya
import EVReflection
import SwiftOTP

// Endpoints
enum CodeStrokeProvider {
    
    case login
    case register(username: String, password: String, first_name: String, last_name: String, email: String, role: String, phone: String)
    case pair(username: String, password: String, pairing_code: String, backend_domain: String, backend_id: String)
    case setPassword(password: String)
    case caseList
    case deleteCase
    case getEDInfo
    case setEDInfo(location: String, registered: Int, triaged: Int, primary_survey: Int)
    case getPatientInfo
    case setPatientInfo(first_name: String, last_name: String, dob: String, address: String, gender: String, last_well: String, nok: String, nok_phone: String, medicare_no: String, hospital_id: String)
    case getClinicalInfo
    case setClinicalInfo(pmhx: String, anticoags_last_dose: String, meds: String, anticoags: String, hopc: String, weight: Float, last_meal: String)
    case getClinicalAssessmentInfo
    case setClinicalAssessmentInfo(facial_droop: String, arm_drift: String, weak_grip: String, speech_difficulty: String, bp_systolic: Int, bp_diastolic: Int, heart_rate: Int, heart_rhythm: String, rr: Int, o2sats: Int, temp: Int, gcs: Int, blood_glucose: Int, facial_palsy_race: Int, arm_motor_impair: Int, leg_motor_impair: Int, head_gaze_deviate: Int, hemiparesis: String, cannula: String, conscious_level: Int, month_age: Int, blink_squeeze: Int, horizontal_gaze: Int, visual_fields: Int, facial_palsy_nihss: Int, left_arm_drift: Int, right_arm_drift: Int, left_leg_drift: Int, right_leg_drift: Int, limb_ataxia: Int, sensation: Int, aphasia: Int, dysarthria: Int, neglect: Int, rankin_conscious: Int, likely_lvo: Bool)
    case getRadiologyInfo
    case setRadiologyInfo(ct_available: Bool, ct_available_loc: String, arrived_to_ct: Bool, ct_complete: Bool, ich_found: Bool, do_cta_ctp: Bool, cta_ctp_complete: Bool, large_vessel_occlusion: Bool)
    case getManagementInfo
    case setManagementInfo(thrombolysis: Bool, new_trauma_haemorrhage: Bool, uncontrolled_htn: Bool, history_ich: Bool, known_intracranial: Bool, active_bleed: Bool, endocarditis: Bool, bleeding_diathesis: Bool, abnormal_blood_glucose: Bool, rapidly_improving: Bool, recent_trauma_surgery: Bool, recent_active_bleed: Bool, seizure_onset: Bool, recent_arterial_puncture: Bool, recent_lumbar_puncture: Bool, post_acs_pericarditis: Bool, pregnant: Bool, thrombolysis_time_given: String, ecr: Bool, surgical_rx: Bool, conservative_rx: Bool)
    case caseCompleted(status: String, completed_timestamp: String)
    case setPatientDetails(first_name: String, last_name: String, dob: String, address: String, gender: String, last_well: String, nok: String, nok_phone: String, hospital_id: String, initial_location_lat: String, initial_location_long: String)
    case setClinicalHistory(pmhx: String, meds: String, anticoags: String, hopc: String, weight: Float, last_meal: String)
    case setClinicalAssessment(facial_droop: String, arm_drift: String, weak_grip: String, speech_difficulty: String, bp_systolic: String, heart_rate: String, heart_rhythm: String, rr: String, o2sats: String, temp: String, gcs: String, blood_glucose: String, facial_palsy_race: String, arm_motor_impair: String, leg_motor_impair: String, head_gaze_deviate: String, cannula: String)
    case dropOff(status: String)
}

// Extends TargetType
extension CodeStrokeProvider: TargetType {
    
    // BaseURL
    var baseURL: URL {
        
//        guard let url = URL(string: "https://codefactor.pythonanywhere.com/") else {
//            Log.fatalError(message: "[CodeStrokeProvider]: URL is not valid.", event: .nullPointer)
//        }
        
        guard let url = URL(string: "https://codestroke.austin.org.au/") else {
            Log.fatalError(message: "[CodeStrokeProvider]: URL is not valid.", event: .nullPointer)
        }
        
        return url
    }
    
    // Path
    var path: String {
        switch self {
        case .login:
            return "clinicians/profile/"
        case .register:
            return "clinicians/register/"
        case .pair:
            return "clinicians/pair/"
        case .setPassword:
            return "clinicians/set_password/"
        case .caseList:
            return "cases/view/"
        case .getEDInfo:
            return "case_eds/\(PrefsManager.getCaseID())/view/"
        case .setEDInfo:
            return "case_eds/\(PrefsManager.getCaseID())/edit/"
        case .getPatientInfo:
            return "cases/\(PrefsManager.getCaseID())/view/"
        case .setPatientInfo, .dropOff:
            return "cases/\(PrefsManager.getCaseID())/edit/"
        case .getClinicalInfo:
            return "case_histories/\(PrefsManager.getCaseID())/view/"
        case .setClinicalInfo, .setClinicalHistory:
            return "case_histories/\(PrefsManager.getCaseID())/edit/"
        case .getClinicalAssessmentInfo:
            return "case_assessments/\(PrefsManager.getCaseID())/view/"
        case .setClinicalAssessmentInfo:
            return "case_assessments/\(PrefsManager.getCaseID())/edit/"
        case .getRadiologyInfo:
            return "case_radiologies/\(PrefsManager.getCaseID())/view/"
        case .setRadiologyInfo:
            return "case_radiologies/\(PrefsManager.getCaseID())/edit/"
        case .getManagementInfo:
            return "case_managements/\(PrefsManager.getCaseID())/view/"
        case .setManagementInfo:
            return "case_managements/\(PrefsManager.getCaseID())/edit/"
        case .caseCompleted:
            return "/cases/\(PrefsManager.getCaseID())/edit/"
        case .setPatientDetails:
            return "cases/add/"
        case .setClinicalAssessment:
            return "case_assessments/\(PrefsManager.getCaseID())/edit/"
        case .deleteCase:
            return "/delete/\(PrefsManager.getCaseID())/"
        }
    }
    
    // Method
    var method: Moya.Method {
        switch self {
        case .register, .pair, .setPassword, .setPatientDetails:
            return .post
        case .login, .caseList, .getEDInfo, .getPatientInfo, .getClinicalInfo, .getClinicalAssessmentInfo, .getRadiologyInfo, .getManagementInfo:
            return .get
        case .setEDInfo, .setPatientInfo, .setClinicalInfo, .setClinicalAssessmentInfo, .setRadiologyInfo, .setManagementInfo, .caseCompleted, .setClinicalHistory, .setClinicalAssessment, .dropOff:
            return .put
        case .deleteCase:
            return .delete
        }
    }
    
    // Task
    var task: Task {
        switch self {
        case .login, .caseList, .getEDInfo, .getPatientInfo, .getClinicalInfo, .getClinicalAssessmentInfo, .getRadiologyInfo, .getManagementInfo, .deleteCase:
            
            return .requestPlain
            
        case .register(let username, let password, let first_name, let last_name, let email, let role, let phone):
            
            let params: [String: String] = ["username": username,
                                            "password": password,
                                            "first_name": first_name,
                                            "last_name": last_name,
                                            "email": email,
                                            "role": role,
                                            "phone": phone]
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .pair(let username, let password, let pairing_code, let backend_domain, let backend_id):
            
            let params: [String: String] = ["username": username,
                                            "password": password,
                                            "pairing_code": pairing_code,
                                            "backend_domain": backend_domain,
                                            "backend_id": backend_id]
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .setPassword(let password):
            
            let params: [String: String] = ["new_password": password]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .setEDInfo(let location, let registered, let triaged, let primary_survey):
            
            let params: [String: Any] = ["location": location,
                                         "registered": registered,
                                         "triaged": triaged,
                                         "primary_survey": primary_survey]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .setPatientInfo(let first_name, let last_name, let dob, let address, let gender, let last_well, let nok, let nok_phone, let medicare_no, let hospital_id):
            
            let params: [String: Any] = ["first_name": first_name,
                                         "last_name": last_name,
                                         "dob": dob,
                                         "address": address,
                                         "gender": gender,
                                         "last_well": last_well,
                                         "nok": nok,
                                         "nok_phone": nok_phone,
                                         "medicare_no": medicare_no,
                                         "hospital_id": hospital_id]
            print(params)
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .setClinicalInfo(let pmhx, let anticoags_last_dose, let meds, let anticoags, let hopc, let weight, let last_meal):
            
            let params: [String: Any] = ["pmhx": pmhx,
                                         "anticoags_last_dose": anticoags_last_dose,
                                         "meds": meds,
                                         "anticoags": anticoags,
                                         "hopc": hopc,
                                         "weight": weight,
                                         "last_meal": last_meal]
            print(params)
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .setClinicalAssessmentInfo(let facial_droop, let arm_drift, let weak_grip, let speech_difficulty, let bp_systolic, let bp_diastolic, let heart_rate, let heart_rhythm, let rr, let o2sats, let temp, let gcs, let blood_glucose, let facial_palsy_race, let arm_motor_impair, let leg_motor_impair, let head_gaze_deviate, let hemiparesis, let cannula, let conscious_level, let month_age, let blink_squeeze, let horizontal_gaze, let visual_fields, let facial_palsy_nihss, let left_arm_drift, let right_arm_drift, let left_leg_drift, let right_leg_drift, let limb_ataxia, let sensation, let aphasia, let dysarthria, let neglect, let rankin_conscious, let likely_lvo):
            
            
            let params: [String: Any] = ["facial_droop": facial_droop,
                                         "arm_drift": arm_drift,
                                         "weak_grip": weak_grip,
                                         "speech_difficulty": speech_difficulty,
                                         "bp_systolic": bp_systolic,
                                         "bp_diastolic": bp_diastolic,
                                         "heart_rate": heart_rate,
                                         "heart_rhythm": heart_rhythm,
                                         "rr": rr,
                                         "o2sats": o2sats,
                                         "temp": temp,
                                         "gcs": gcs,
                                         "blood_glucose": blood_glucose,
                                         "facial_palsy_race": facial_palsy_race,
                                         "arm_motor_impair": arm_motor_impair,
                                         "leg_motor_impair": leg_motor_impair,
                                         "head_gaze_deviate": head_gaze_deviate,
                                         "hemiparesis": hemiparesis,
                                         "cannula": cannula,
                                         "conscious_level": conscious_level,
                                         "month_age": month_age,
                                         "blink_squeeze": blink_squeeze,
                                         "horizontal_gaze": horizontal_gaze,
                                         "visual_fields": visual_fields,
                                         "facial_palsy_nihss": facial_palsy_nihss,
                                         "left_arm_drift": left_arm_drift,
                                         "right_arm_drift": right_arm_drift,
                                         "left_leg_drift": left_leg_drift,
                                         "right_leg_drift": right_leg_drift,
                                         "limb_ataxia": limb_ataxia,
                                         "sensation": sensation,
                                         "aphasia": aphasia,
                                         "dysarthria": dysarthria,
                                         "neglect": neglect,
                                         "rankin_conscious": rankin_conscious,
                                         "likely_lvo": likely_lvo]
            print(params)
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .setRadiologyInfo(let ct_available, let ct_available_loc, let arrived_to_ct, let ct_complete, let ich_found, let do_cta_ctp, let cta_ctp_complete, let large_vessel_occlusion):
            
            let params: [String: Any] = ["ct_available": ct_available,
                                         "ct_available_loc": ct_available_loc,
                                         "arrived_to_ct": arrived_to_ct,
                                         "ct_complete": ct_complete,
                                         "ich_found": ich_found,
                                         "do_cta_ctp": do_cta_ctp,
                                         "cta_ctp_complete": cta_ctp_complete,
                                         "large_vessel_occlusion": large_vessel_occlusion]
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .setManagementInfo(let thrombolysis, let new_trauma_haemorrhage, let uncontrolled_htn, let history_ich, let known_intracranial, let active_bleed, let endocarditis, let bleeding_diathesis, let abnormal_blood_glucose, let rapidly_improving, let recent_trauma_surgery, let recent_active_bleed, let seizure_onset, let recent_arterial_puncture, let recent_lumbar_puncture, let post_acs_pericarditis, let pregnant, let thrombolysis_time_given, let ecr, let surgical_rx, let conservative_rx):
            
            let params: [String: Any] = ["thrombolysis": thrombolysis,
                                         "new_trauma_haemorrhage": new_trauma_haemorrhage,
                                         "uncontrolled_htn": uncontrolled_htn,
                                         "history_ich": history_ich,
                                         "known_intracranial": known_intracranial,
                                         "active_bleed": active_bleed,
                                         "endocarditis": endocarditis,
                                         "bleeding_diathesis": bleeding_diathesis,
                                         "abnormal_blood_glucose": abnormal_blood_glucose,
                                         "rapidly_improving": rapidly_improving,
                                         "recent_trauma_surgery": recent_trauma_surgery,
                                         "recent_active_bleed": recent_active_bleed,
                                         "seizure_onset": seizure_onset,
                                         "recent_arterial_puncture": recent_arterial_puncture,
                                         "recent_lumbar_puncture": recent_lumbar_puncture,
                                         "post_acs_pericarditis": post_acs_pericarditis,
                                         "pregnant": pregnant,
                                         "thrombolysis_time_given": thrombolysis_time_given,
                                         "ecr": ecr,
                                         "surgical_rx": surgical_rx,
                                         "conservative_rx": conservative_rx]
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .caseCompleted(let status, let completed_timestamp):

            let params: [String: String] = ["status": status,
                                            "completed_timestamp": completed_timestamp]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .setPatientDetails(let first_name, let last_name, let dob, let address, let gender, let last_well, let nok, let nok_phone, let hospital_id, let initial_location_lat, let initial_location_long):
            
            let params = ["first_name": first_name,
                         "last_name": last_name,
                         "dob": dob,
                         "address": address,
                         "gender": gender,
                         "last_well": last_well,
                         "nok": nok,
                         "nok_phone": nok_phone,
                         "hospital_id": hospital_id,
                         "initial_location_long": initial_location_long,
                         "initial_location_lat": initial_location_lat]
            print(params)
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .setClinicalHistory(let pmhx, let meds, let anticoags, let hopc, let weight, let last_meal):
            
            let params: [String : Any] = ["pmhx": pmhx,
                          "meds": meds,
                          "anticoags": anticoags,
                          "hopc": hopc,
                          "weight": weight,
                          "last_meal": last_meal]
            print(params)
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .setClinicalAssessment(let facial_droop, let arm_drift, let weak_grip, let speech_difficulty, let bp_systolic, let heart_rate, let heart_rhythm, let rr, let o2sats, let temp, let gcs, let blood_glucose, let facial_palsy_race, let arm_motor_impair, let leg_motor_impair, let head_gaze_deviate, let cannula):
            
            let param: [String : Any] = ["facial_droop": facial_droop,
                                         "arm_drift": arm_drift,
                                         "weak_grip": weak_grip,
                                         "speech_difficulty": speech_difficulty,
                                         "bp_systolic": bp_systolic,
                                         "heart_rate": heart_rate,
                                         "heart_rhythm": heart_rhythm,
                                         "rr": rr,
                                         "o2sats": o2sats,
                                         "temp": temp,
                                         "gcs": gcs,
                                         "blood_glucose": blood_glucose,
                                         "facial_palsy_race": facial_palsy_race,
                                         "arm_motor_impair": arm_motor_impair,
                                         "leg_motor_impair": leg_motor_impair,
                                         "head_gaze_deviate": head_gaze_deviate,
                                         "cannula": cannula]
            print(param)
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        case .dropOff(let status):
            
            let params: [String: Any] = ["status": status]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    // SampleData: This is not necessary
    var sampleData: Data {
        return "{\"success\": false,\"action\": null,\"failure_reason\": \"wrong_credentials\"}".data(using: .utf8)!
    }
    
    // Headers
    var headers: [String: String]? {
        switch self {
            
        case .login:
            
            let tokenInfo = PrefsManager.getSavedData(for: TOKENINFO) as! TokenInfo
            let userCreds = PrefsManager.getSavedData(for: ENTEREDCREDS) as! EnteredCreds
            let username = userCreds.username
            
            let data = tokenInfo.shared_secret.base32DecodedData
            let totp = TOTP(secret: data!, digits: 6, timeInterval: 300, algorithm: .sha1)!
            let token = totp.generate(time: Date())
            print("Token: ",token)
            let password = "\(PrefsManager.getPass()):\(token)"
            let loginString = String(format: "%@:%@", username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            return ["Content-Type": "application/json",
                    "Authorization": "Basic \(base64LoginString)"]
            
        case .register:
            
            let username = "admin"
            let password = "password"
            let loginString = String(format: "%@:%@", username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            return ["Content-Type": "application/json",
                    "Authorization": "Basic \(base64LoginString)"]
            
        case .pair:
            
            return ["Content-Type": "application/json"]
            
        case .setPassword:
            
            let tokenInfo = PrefsManager.getSavedData(for: TOKENINFO) as! TokenInfo
            let username = tokenInfo.username
            
            let data = tokenInfo.shared_secret.base32DecodedData
            let totp = TOTP(secret: data!, digits: 6, timeInterval: 300, algorithm: .sha1)!
            let token = totp.generate(time: Date())
            print("Token: ",token)
            let password = "\(tokenInfo.password):\(token)"
            let loginString = String(format: "%@:%@", username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            return ["Content-Type": "application/json",
                    "Authorization": "Basic \(base64LoginString)"]
            
        case .caseList, .getPatientInfo, .getClinicalInfo, .getClinicalAssessmentInfo, .getRadiologyInfo, .getManagementInfo:
            
            let tokenInfo = PrefsManager.getSavedData(for: TOKENINFO) as! TokenInfo
            let userCreds = PrefsManager.getSavedData(for: ENTEREDCREDS) as! EnteredCreds
            let username = userCreds.username
            
            let data = tokenInfo.shared_secret.base32DecodedData
            let totp = TOTP(secret: data!, digits: 6, timeInterval: 300, algorithm: .sha1)!
            let token = totp.generate(time: Date())
            print("Token: ",token)
            let password = "\(PrefsManager.getPass()):\(token)"
            let loginString = String(format: "%@:%@", username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            return ["Content-Type": "application/json",
                    "Authorization": "Basic \(base64LoginString)"]
            
        case .getEDInfo:
            
            let tokenInfo = PrefsManager.getSavedData(for: TOKENINFO) as! TokenInfo
            let userCreds = PrefsManager.getSavedData(for: ENTEREDCREDS) as! EnteredCreds
            let username = userCreds.username
            
            let data = tokenInfo.shared_secret.base32DecodedData
            let totp = TOTP(secret: data!, digits: 6, timeInterval: 300, algorithm: .sha1)!
            let token = totp.generate(time: Date())
            print("Token: ",token)
            let password = "\(PrefsManager.getPass()):\(token)"
            let loginString = String(format: "%@:%@", username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            
            return ["Authorization": "Basic \(base64LoginString)"]
            
    case .setEDInfo, .setPatientInfo, .setClinicalInfo, .setClinicalAssessmentInfo, .setRadiologyInfo, .setManagementInfo, .caseCompleted, .setClinicalHistory:
            
            let tokenInfo = PrefsManager.getSavedData(for: TOKENINFO) as! TokenInfo
            let userCreds = PrefsManager.getSavedData(for: ENTEREDCREDS) as! EnteredCreds
            let username = userCreds.username
            
            let data = tokenInfo.shared_secret.base32DecodedData
            let totp = TOTP(secret: data!, digits: 6, timeInterval: 300, algorithm: .sha1)!
            let token = totp.generate(time: Date())
            print("Token: ",token)
            let password = "\(PrefsManager.getPass()):\(token)"
            let loginString = String(format: "%@:%@", username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            return ["Content-Type": "application/json",
                    "Authorization": "Basic \(base64LoginString)"]
            
        case .setPatientDetails, .setClinicalAssessment, .dropOff, .deleteCase:
            
            let tokenInfo = PrefsManager.getSavedData(for: TOKENINFO) as! TokenInfo
            let userCreds = PrefsManager.getSavedData(for: ENTEREDCREDS) as! EnteredCreds
            let username = userCreds.username
            
            let data = tokenInfo.shared_secret.base32DecodedData
            let totp = TOTP(secret: data!, digits: 6, timeInterval: 300, algorithm: .sha1)!
            let token = totp.generate(time: Date())
            
            let password = "\(PrefsManager.getPass()):\(token)"
            let loginString = String(format: "%@:%@", username, password)
            print("Username: Password \(username)\(password)")
            print("Token: ",token)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            return ["Content-Type": "application/json",
                    "Authorization": "Basic \(base64LoginString)"]
        }
    }
    
    public var authorizationType: AuthorizationType {
        switch self {
        case .pair:
            return .none
        case .login, .register, .setPassword, .caseList, .getEDInfo, .setEDInfo, .getPatientInfo, .setPatientInfo, .getClinicalInfo, .setClinicalInfo, .getClinicalAssessmentInfo, .setClinicalAssessmentInfo, .getRadiologyInfo, .setRadiologyInfo, .getManagementInfo, .setManagementInfo, .caseCompleted, .setPatientDetails, .setClinicalHistory, .setClinicalAssessment, .dropOff, .deleteCase:
            return .basic
        }
    }
}

