//
//  ApiBody.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 01/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import UIKit

// ApiBody static keys
fileprivate let PM_API_PRM_SECRET_TOKEN = "secret_token"
fileprivate let PM_API_PRM_INSTALL_ID   = "installation_id"
fileprivate let PM_API_PRM_OS_VER       = "os_version"
fileprivate let PM_API_PRM_APP_VER      = "app_version"
fileprivate let PM_API_LANG             = "language"

// APIBody
struct ApiBody {
    
    // Lets
    private static let secretToken: String    = "be7df5f7bade7cacadc5deed67f259bd96211ed805f008f2f39567a795a430495ab0757f97da1acd733743db4f255fe97a54baf9bab4f0975966a5109d2a5dcf"
    private static let osVersion: String      = "ios-\(UIDevice.current.systemVersion)"
    private static let appVersion: String     = Bundle.main.bundleShortVersion
    private static let installationId: String = UIDevice.current.identifierForVendor?.uuidString ?? ""
    private static let language: String       = "en"
    
    // Base
    internal static var base: [String: String] {
        return [:]
    }
    
    // Login
    internal static func login(username: String, password: String) -> [String: String] {
        var returnable = ApiBody.base
        returnable["username"]      = username
        returnable["password"]      = password
        return returnable
    }
}
