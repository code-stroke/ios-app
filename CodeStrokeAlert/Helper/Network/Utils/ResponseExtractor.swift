//
//  ResponseExtractor.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 29/09/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation

class ResponseExtractor {
    
    // Vars
    fileprivate var responseDict: NSDictionary!
    
    // Init with data object
    convenience init(dict: NSDictionary? = nil, data: Data? = nil) throws {
        
        // Check if dict was passed as parameter
        if let dict = dict {
            
            // Init
            self.init()
            
            // Set responseDict
            self.responseDict = dict
            
            // Return here
            return
        }
        
        // Check for data
        guard let data = data else { throw NSError(domain: "[ResponseExtractor]: Passed data is nil.", code: 1, userInfo: nil) }
        
        // Check for dict
        do {
            let dict = try JSONSerialization.jsonObject(with: data, options: [.allowFragments, .mutableContainers, .mutableLeaves]) as? NSDictionary
            
            // Init
            self.init()
            
            // Set responseDict
            self.responseDict = dict
            
        } catch {
            throw NSError(domain: "[ResponseExtractor]: \(error.localizedDescription)", code: 2, userInfo: nil)
        }
    }
}

// Extension
extension ResponseExtractor {
    
    // Int
    func intValue(for key: String) -> Int? {
        return self.responseDict.value(forKey: key) as? Int
    }
    
    // Float
    func floatValue(for key: String, fromString: Bool = true) -> Float? {
        if !fromString {
            return self.responseDict.value(forKey: key) as? Float
        }
        return (self.responseDict.value(forKey: key) as? NSString)?.floatValue
    }
    
    // String
    func stringValue(for key: String) -> String? {
        return self.responseDict.value(forKey: key) as? String
    }
    
    // Bool
    func boolValue(for key: String) -> Bool {
        return self.responseDict.value(forKey: key) as? Bool ?? false
    }
    
    // Dict
    func dictValue(for key: String) -> NSDictionary? {
        return self.responseDict.value(forKey: key) as? NSDictionary
    }
    
    // Array
    func arrayValue<T>(for key: String) -> [T] {
        return self.responseDict.value(forKey: key) as? [T] ?? []
    }
    
    // Custom types
    func value(for key: String) -> Any? {
        return self.responseDict.value(forKey: key)
    }
}
