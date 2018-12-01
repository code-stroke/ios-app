//
//  DatabaseProvider.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 29/09/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import RealmSwift

// Class is declared as "internal" for Unit Tests purpose
fileprivate class DatabaseProviderInternal {
    
    // Realm instance accessible from 'DatabaseProviderInternal.shared'
    fileprivate class var database: Realm? {
        get {
            return self.loadDatabase()
        }
    }
    
    // Load Database based on inMemoryIdentifier
    private class func loadDatabase() -> Realm? {
        
        var __realm: Realm? = nil
        
        do {
            // Initialise Realm
            if let inMemoryId = DatabaseProvider.inMemoryIdentifier {
                __realm = try Realm(configuration: Realm.Configuration(inMemoryIdentifier: inMemoryId))
            } else {
                __realm = try Realm()
            }
            
            // Manual refresh after initialization
            __realm?.refresh()
            
        } catch {
            Log.debug(message: "[DatabaseProviderInternal]: Can't initialize Realm. Reason: \(error.localizedDescription)", event: .error)
        }
        
        // Return nil
        return __realm
    }
}

class DatabaseProvider {
    
    // If setted, Realm data will be read/written in memory without modifying the 'default.realm' file.
    static var inMemoryIdentifier: String?
    
    // Hide unwanted init function
    private init() {}
    
    // Write block
    // Parameter completion: A completion block to be execute inside Realm.write{} block
    class func write(completion: @escaping () -> ()) {
        do {
            try DatabaseProviderInternal.database?.write {
                completion()
            }
        } catch {
            Log.debug(message: "Write block failed. Reason: \(error.localizedDescription)", event: .error)
        }
    }
    
    // Read all objects of given type
    // Parameter type: The object's type to be returned
    class func objects<Element: Object>(type: Element.Type) -> Results<Element>? {
        let results = DatabaseProviderInternal.database?.objects(type)
        Log.debug(message: "\(results?.count ?? 0) objects of type \(type) was read.", event: .info)
        return results
    }
    
    // Get an object of given type for given key
    // Parameter type: The object's type to be returned
    // Parameter key: The key used to filter items
    class func object<Element: Object, K>(type: Element.Type, primaryKey: K) -> Element? {
        if let result = DatabaseProviderInternal.database?.object(ofType: type, forPrimaryKey: primaryKey) {
            Log.debug(message: "One object for given primary-key \"\(primaryKey)\" found for type \"\(type)\".", event: .info)
            return result
        }
        Log.debug(message: "Can't find object for given primary-key \"\(primaryKey)\" of type \"\(type)\".", event: .info)
        return nil
    }
    
    // Write transaction with single object
    // Parameter object: The object to be added to Realm
    class func add(_ object: Object, update: Bool = false) {
        Log.debug(message: "Adding \(object.description)...", event: .info)
        DatabaseProviderInternal.database?.add(object, update: update)
    }
    
    // Write transaction with array of objects
    // Parameter objects: The array of objects to be added to Realm
    class func add(_ objects: [Object], update: Bool = false) {
        Log.debug(message: "Adding \(objects.count) objects...", event: .info)
        DatabaseProviderInternal.database?.add(objects, update: update)
    }
    
    // Delete passed object
    // Parameter object: The object to be deleted from Realm
    class func delete(_ object: Object) {
        Log.debug(message: "Deleting \(object.description)...", event: .info)
        DatabaseProviderInternal.database?.delete(object)
    }
    
    // Delete passed array of objects
    // Parameter objects: The array of objects to be deleted to Realm
    class func delete(_ objects: [Object]) {
        Log.debug(message: "Deleting \(objects.count) objects...", event: .info)
        DatabaseProviderInternal.database?.delete(objects)
    }
    
    // Delete all data from Realm
    class func deleteAll() {
        do {
            try DatabaseProviderInternal.database?.write {
                Log.debug(message: "Deleting all objects...", event: .info)
                DatabaseProviderInternal.database?.deleteAll()
            }
        } catch {
            Log.debug(message: "Can't delete all data. Reason: \(error.localizedDescription)", event: .error)
        }
    }
}
