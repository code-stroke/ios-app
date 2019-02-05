//
//  CodeStrokeProvider.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 30/09/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import Moya

// Endpoints
enum CodeStrokeProvider {
    case login(username: String, password: String)
}

// Extends TargetType
extension CodeStrokeProvider: TargetType {
    
    // BaseURL
    var baseURL: URL {
        guard let url = URL(string: "https://codestroke.austin.org.au/clinicians") else {
            Log.fatalError(message: "[CodeStrokeProvider]: URL is not valid.", event: .nullPointer)
        }
        
        return url
    }
    
    // Path
    var path: String {
        switch self {
        case .login:
            return "login/"
        }
    }
    
    // Method
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    // Task
    var task: Task {
        switch self {
        case .login(let username, let password):
            
            let params: [String: String] = ["username": username, //convert to string
                                            "password": password]
            
            var multipartData = [MultipartFormData]()
            for (key, value) in params {
                let formData = MultipartFormData(provider: .data(value.data(using: .utf8)!), name: key)
                multipartData.append(formData)
            }
            
            return .uploadMultipart(multipartData)
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
            return ["Content-Type": "application/json"]
        }
    }
}

