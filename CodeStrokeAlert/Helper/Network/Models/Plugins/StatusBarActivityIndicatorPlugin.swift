//
//  StatusBarActivityIndicatorPlugin.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 01/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import Moya
import Result

internal final class StatusBarActivityIndicatorPlugin: PluginType {
    
    // This is executed before request starts
    func willSend(_ request: RequestType, target: TargetType) {
        // Show activity indicator in Status Bar
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // This is executed after response is received
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        // Hide activity indicator from Status Bar
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
