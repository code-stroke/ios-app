//
//  Utils.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 29/09/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import SystemConfiguration

public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
}

// Utils class
internal class Utils {
    
    /// Execute on `main` thread (async)
    /// - parameter after: This is the amount of time to wait until closure will be executed.
    /// - parameter closure: This is the closure to be executed.
    class func execute(after: Double = 0, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(after * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    /// Execute on `background` thread (async)
    /// - parameter after: This is the amount of time to wait until closure will be executed.
    /// - parameter closure: This is the closure to be executed.
    class func executeOnBackground(after: Double = 0, closure: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime.now() + Double(Int64(after * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    /// Load a view from a Nib (`.xib`) file and cast to given type.
    /// You can use this function like this: `let view: CustomView = Utils.loadView(fromNib: "CustomView")`.
    /// - parameter fromNib: This is the `.xib` filename.
    class func loadView<T>(fromNib name: String) -> T {
        if let t = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T { return t }
        Log.fatalError(message: "Could not load view with type " + String(describing: T.self), event: .nullPointer)
    }
    
    // MARK: Toaster
    ///
    /// Show toaster for given message
    /// - parameter message: The message that will be showed inside a `Toast`.
    /// - parameter delay: This is the amount of time to wait until toast will be displayed.
    /// - parameter duration: This is the amount of time while toast is visible on screen.
    class func showToast(_ message: String,
                         delay: TimeInterval = 0,
                         duration: TimeInterval = 3,
                         bottomOffset: CGFloat? = nil,
                         backgroundColor: UIColor = UIColor.purple,
                         textColor: UIColor = .white,
                         cornerRadius: CGFloat = 3.75) {
        /// Hide all previous toasts
        ToastCenter.default.cancelAll()
        /// Init toast
        let toast = Toast(text: message, delay: delay, duration: duration)
        /// Check for appaerance
        if let bottomOffset = bottomOffset { toast.view.bottomOffsetPortrait = bottomOffset }
        /// Set appaerance values
        toast.view.backgroundColor = backgroundColor
        toast.view.textColor = textColor
        toast.view.cornerRadius = cornerRadius
        /// Show toast
        toast.show()
    }
}
