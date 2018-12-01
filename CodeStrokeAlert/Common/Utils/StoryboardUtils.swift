//
//  StoryboardUtils.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 29/09/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import UIKit

// MARK: UIStoryBoards identifiers-
extension UIStoryboard {
    
    enum Storyboard: String {
        
        case main
        case login
        case register
        case password
        case patientdetail
        case hospital
        case medical
        case mass
        case vitals
        case race
        case cannula
        case summary
        case patientlist
        case clinician
        
        // Real filename
        var filename: String { return rawValue.capitalized }
    }
    
    // Retrieve `UIStoryboard` for given `Storyboard` enum
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    // Instantiate view controller with generics
    func instantiate<T: UIViewController>() -> T {
        
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            Log.fatalError(message: "Can't instantiate view controller with identifier: \(T.storyboardIdentifier)", event: .nullPointer)
        }
        return viewController
    }
}

// MARK:- UIViewControllers identifiers -
// Protocol to give any class that conform it a static variable `storyboardIdentifier`
protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

// Protocol extension to implement `storyboardIdentifier` variable only when `Self` is of type `UIViewController`
extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String { return String(describing: self) }
}

// Create `UIViewController` extension to conform to `StoryboardIdentifiable`
extension UIViewController: StoryboardIdentifiable {}
