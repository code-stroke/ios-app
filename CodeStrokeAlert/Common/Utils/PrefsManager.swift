//
//  PrefsManager.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 29/09/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import EVReflection

let USER_TYPE: String           = "userType"
let USER_ROLE: String           = "userRole"
let LOGIN_USER_ID: String       = "userId"
let CASE_ID: String             = "caseId"
let TOKENINFO: String           = "userInfo"
let USERPASS: String            = ""
let ENTEREDCREDS: String        = "creds"

enum UserRole: String {
    
    case admin = "Admin",
         anaesthetist = "Anaesthetist",
         angio_nurse = "Angiography Nurse",
         ed_clinician = "ED Clinician",
         neuroint = "Neurointerventionalist",
         paramedic = "Paramedic",
         radiographer = "Radiographer",
         radiologist = "Radiologist",
         stroke_team = "Stroke Team",
         stroke_ward = "Stroke Ward"
    
    static let allValues = [admin, anaesthetist, angio_nurse, ed_clinician, neuroint, paramedic, radiographer, radiologist, stroke_team, stroke_ward]
}

enum UserType: String {
    
    case paramedic = "Paramedic", clinician = "Clinician"
    static let allValues = [paramedic, clinician]
}

class PrefsManager {
    
    // Set User Type
    static func setUserType(userType: String) {
        
        UserDefaults.standard.set(userType, forKey: USER_TYPE)
    }
    
    // Get User Type
    static func getUserType() -> String {
        
        guard let userType = UserDefaults.standard.string(forKey: USER_TYPE) else {
            return ""
        }
        
        return userType
    }
    
    // Get Pass
    static func setPass(password: String) {
        
        UserDefaults.standard.set(password, forKey: USERPASS)
    }
    
    // Get Pass
    static func getPass() -> String {
        
        guard let userPass = UserDefaults.standard.string(forKey: USERPASS) else {
            return ""
        }
        
        return userPass
    }
    
    // Set User Role
    static func setUserRole(userRole: String) {
        
        UserDefaults.standard.set(userRole, forKey: USER_ROLE)
    }
    
    // Get User Type
    static func getUserRole() -> String {
        
        guard let userRole = UserDefaults.standard.string(forKey: USER_ROLE) else {
            return ""
        }
        
        return userRole
    }
    
    // Set User ID
    static func setUserId(userId: Int) {
        
        UserDefaults.standard.set(userId, forKey: LOGIN_USER_ID)
    }
    
    // Get User ID
    static func getUserId() -> Int {
        
        return UserDefaults.standard.integer(forKey: LOGIN_USER_ID)
    }
    
    // Set User ID
    static func setCaseID(userId: Int) {
        
        UserDefaults.standard.set(userId, forKey: CASE_ID)
    }
    
    // Get User ID
    static func getCaseID() -> Int {
        
        return UserDefaults.standard.integer(forKey: CASE_ID)
    }
    
    // Save EVObject in PrefManager
    static func saveData(for key: String, and data: EVObject) {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data: NSData = NSKeyedArchiver.archivedData(withRootObject: data) as NSData
        defaults.set(data, forKey: key)
        defaults.synchronize()
    }
    
    // Get EVObject from PrefManager
    static func getSavedData(for key: String) -> EVObject? {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data = defaults.object(forKey: key) as? NSData
        
        if data != nil {
            
            if let info = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) {
                return (info as! EVObject)
            }
            else {
                return nil
            }
        }
        return nil
    }
    
    // Clear EVObject from PrefManager
    static func clearSavedData(for key: String) {
        
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
}
