//
//  Extensions.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 29/09/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import UIKit
import Lottie

public func isEmptyString(_ text : String) -> Bool {
    
    if text.trim == "" || text.trim.isEmpty {
        return true
    } else {
        return false
    }
}

public func validateEmailWithString(_ Email: String) -> Bool {
    do {
        let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
        return !(regex.firstMatch(in: Email, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, Email.count)) != nil)
    } catch {
        return true
    }
}

func setDeviceToken(_ token : String) {
    
    let defaults: UserDefaults = UserDefaults.standard
    let data: Data = NSKeyedArchiver.archivedData(withRootObject: token)
    defaults.set(data, forKey: "deviceToken")
    defaults.synchronize()
}

func getDeviceToken() -> String {
    
    let defaults: UserDefaults = UserDefaults.standard
    let data = defaults.object(forKey: "deviceToken") as? Data
    if data != nil {
        
        if let str = NSKeyedUnarchiver.unarchiveObject(with: data!) as? String {
            return str
        }
        else {
            return "Simulator"
        }
    }
    return "Simulator"
}

func removeDeviceToken() {
    
    let defaults: UserDefaults = UserDefaults.standard
    defaults.removeObject(forKey: "deviceToken")
    defaults.synchronize()
}

extension UIViewController {
    
    func gradientWithFrametoImage(frame: CGRect, colors: [CGColor]) -> UIImage? {
        
        let gradient: CAGradientLayer  = CAGradientLayer(layer: self.view.layer)
        gradient.frame = frame
        gradient.colors = colors
        UIGraphicsBeginImageContext(frame.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

// UIView
extension UIView {
    /// Create UIView's copy
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
    /// Animate alpha from X to Y
    func setAlpha(toValue: CGFloat, animated: Bool = true) {
        UIView.animate(withDuration: animated ? 0.3 : 0, animations: {
            self.alpha = toValue
        })
    }
    /// Set hidden (animated)
    func setHidden(_ hidden: Bool, animated: Bool = true, delay: TimeInterval = 0) {
        self.isHidden = hidden
        UIView.animate(withDuration: animated ? 0.3 : 0, delay: delay, animations: {
            self.alpha = hidden ? 0 : 1
        })
    }
    /// Get subview for given tag
    func subview(forTag tag: Int) -> UIView? {
        return self.subviews.filter({ $0.tag == tag }).first
    }
    /// Add drop shadow
    func addDropShadow(path: CGPath? = nil, offset: CGSize = .zero, radius: CGFloat = 3, color: UIColor = .black, opacity: CGFloat = 1) {
        self.layer.shadowPath = path
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = Float(opacity)
    }
    /// Remove drop shadow.
    /// This function can be animated since the value that will be changed are: `layer.shadowRadius` and `layer.shadowOpacity`
    func removeDropShadow() {
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0
    }
    /// Add corner radius only to given corners
    func addCornerRadius(forCorners corners: UIRectCorner, radius: CGFloat) {
        /// Uptade auto layout before doing anything
        self.layoutIfNeeded()
        /// Create shape
        let shape = CAShapeLayer()
        shape.bounds = self.frame
        shape.position = self.center
        shape.path = UIBezierPath(roundedRect: self.bounds,
                                  byRoundingCorners: corners,
                                  cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.mask = shape
    }
    //    /// Access cornerRadius easly
    //    var cornerRadius: CGFloat {
    //        get { return self.layer.cornerRadius }
    //        set { self.layer.cornerRadius = newValue }
    //    }
    /// Easier SIZE (height & widht) and ORIGIN (x & y) getter and setter
    var size: CGSize {
        get { return self.frame.size }
        set { self.frame.size = newValue }
    }
    var origin: CGPoint {
        get { return self.frame.origin }
        set { self.frame.origin = newValue }
    }
    var height: CGFloat {
        get { return self.frame.size.height }
        set { self.frame.size.height = newValue }
    }
    var width1: CGFloat {
        get { return self.frame.size.width }
        set { self.frame.size.width = newValue }
    }
    var x: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    var y: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    /// Update view's content size based on its subviews
    /// - parameter vertically: If true, superview will be resized based on its subviews vertically
    /// - parameter horizontally: If true, superview will be resized based on its subviews horizontally
    func updateContentSize(vertically: Bool = true, horizontally: Bool = true) {
        /// Get max Y and H
        if vertically {
            var max: CGFloat = 0
            self.subviews.forEach({
                if ($0.y + $0.height) > max { max = $0.y + $0.height }
            })
            self.height = max
        }
        if horizontally {
            var max: CGFloat = 0
            self.subviews.forEach({
                if ($0.x + $0.width1) > max { max = $0.x + $0.width1 }
            })
            self.width1 = max
        }
    }
    /// Layout subviews vertically, horizontally or as grid
    enum LayoutDistribution {
        /// - parameter spacing: This is the space between one item and its next one
        case vertically(spacing: CGFloat)
        /// - parameter spacing: This is the space between one item and its next one
        /// - parameter forceWidth: If true, item's width will be changed to fit parent view width
        case horizontally(spacing: CGFloat, forceWidth: Bool)
        /// - parameter colNum: This is the max column number
        /// - parameter width: This is the item width
        /// - parameter height: This is the item height
        /// - parameter colSpacing: This is the space between columns
        /// - parameter rowSpacing: This is the space between rows
        /// - parameter alignment: This is how the items will be represented, all aligned to left, centered or right. Only `left`, `center` and `right` case can be used. If `justified` is selected, then `spacing` will not be used.
        case grid(colNum: Int, width: CGFloat, height: CGFloat?, colSpacing: CGFloat, rowSpacing: CGFloat, alignment: NSTextAlignment)
    }
    /// Layout subviews vertically, horizontally or as grid
    /// - parameter distribution: This is how subviews will be positioned
    func layoutSubviews(distribution: LayoutDistribution) {
        
        /// Init variable `lastView`
        var lastView: UIView!
        
        /// Switch for distribution
        switch distribution {
        case .vertically(let spacing):
            
            /// Iterate on subviews
            self.subviews.enumerated().forEach({ index,subview in
                /// Check if is first
                if index == 0 {
                    subview.y = 0
                }else {
                    subview.y = lastView.y + lastView.height + spacing
                }
                lastView = subview
            })
            /// Update content size
            self.updateContentSize(vertically: true, horizontally: false)
            
        case .horizontally(let spacing, let forceWidth):
            
            /// Get subviews count
            let count = self.subviews.count
            /// Iterate on subviews
            self.subviews.enumerated().forEach({ index,subview in
                /// Set width (if wanted)
                subview.width1 = forceWidth ? (self.width1 / CGFloat(count)) : subview.width1
                /// Check if is first
                if index == 0 {
                    subview.x = 0
                }else {
                    subview.x = lastView.x + lastView.width1 + spacing
                }
                lastView = subview
            })
            /// Update content size
            self.updateContentSize(vertically: false, horizontally: true)
            
        case .grid(let colNum, let width, let height, var colSpacing, let rowSpacing, let alignment):
            
            /// If alignment is `justified` then calculate spacing based on self view width
            if alignment == .justified {
                colSpacing = (self.width1 - (width * CGFloat(colNum))) / CGFloat(colNum - 1)
            }
            /// Col control
            var col: Int = 0
            /// Create container view
            let containerView = UIView(frame: .zero)
            containerView.backgroundColor = .clear
            /// Iterate on subviews
            self.subviews.enumerated().forEach({ index,subview in
                /// Remove subview from self and add to container view instead
                subview.removeFromSuperview()
                containerView.addSubview(subview)
                /// Set size
                subview.size = CGSize(width: width, height: height ?? subview.height)
                /// Check if is first
                if index == 0 {
                    subview.x = 0
                    subview.y = 0
                }else {
                    if col < colNum {
                        subview.x = lastView.x + lastView.width1 + colSpacing
                        subview.y = lastView.y
                    }else {
                        subview.x = 0
                        subview.y = lastView.y + lastView.height + rowSpacing
                        col = 0
                    }
                }
                col += 1
                lastView = subview
            })
            /// Update container content size
            containerView.updateContentSize()
            /// Switch for alignment
            switch alignment {
            case .center:
                containerView.center.x = self.width1 / 2
            case .right:
                containerView.x = self.width1 - containerView.width1
            default:
                containerView.x = 0
            }
            /// Add container view to self
            self.addSubview(containerView)
            /// Update content size
            self.updateContentSize(vertically: true, horizontally: false)
        }
    }
    
    func setCornerRadius(cornerRadius: CGFloat, borderWidth: CGFloat, color: UIColor) {
        
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
}

// UIButton
extension UIButton {
    
    // Start is loading (replace title with activity indicator)
    // - parameter withSpinnerColor: This is the color of the Loading Spinner view
    // - parameter backgroundColor: This is the background color the button will have during loading animation. If `nil`, current background color will be used.
    // - parameter makeUnresponsive: If `true`, button will not be enabled while loading
    func startLoading(withSpinnerColor color: UIColor = .white, backgroundColor: UIColor? = nil, makeUnresponsive: Bool = true) {
        
        // Stop loading before init new animation
        self.stopLoading()
        
        // Create Lottie view
        let animationView = LOTAnimationView(name: "spinner")
        animationView.size = self.size.midSize(factor: 1.75)
        animationView.center = self.size.center
        animationView.contentMode = .scaleAspectFit
        
        // Change spinner color programmatically
        let keypath = LOTKeypath(string: "spinner Outlines.Group 1.Stroke 1.Color")
        let color = LOTColorValueCallback(color: color.cgColor)
        animationView.setValueDelegate(color, for: keypath)
        
        // Set a specific tag for activityIndicator. This is needed for `stopLoading` function
        animationView.tag = 0088
        
        // Add as subview
        self.addSubview(animationView)
        
        // Hide title and image view
        // These need to be removed from superview 'cause changing `isHidden` property or `alpha` property doesn't take any effect.
        self.titleLabel?.removeFromSuperview()
        self.imageView?.removeFromSuperview()
        
        // Center it
        animationView.center = CGPoint(x: self.width1 / 2, y: self.height / 2)
        
        // Animate
        animationView.loopAnimation = true
        animationView.play()
        
        // Change background color
        self.backgroundColor = backgroundColor ?? self.backgroundColor
        
        // Should be unresponsive?
        self.isEnabled = !makeUnresponsive
    }
    
    // Stop loading animation
    // - parameter newTitle: This could be the title the button will have after stop loading
    // - parameter newImage: This could be the image the button will have after stop loading
    // - parameter newBackgroundColor: This could be the background color the button will have after stop loading. If `nil`, current background color will be used.
    // - parameter makeUnresponsive: If `true`, button will not be enabled after loading has stopped
    func stopLoading(newTitle: String? = nil, newImage: UIImage? = nil, newBackgroundColor: UIColor? = nil, makeUnresponsive: Bool = false) {
        // Get activity indicator
        if let animationView = self.subview(forTag: 0088) as? LOTAnimationView {
            
            // Stop animation
            animationView.stop()
            
            // Remove from superview
            animationView.removeFromSuperview()
            
            // Show title/image back
            if let titleLabel = self.titleLabel {
                self.addSubview(titleLabel)
            }
            
            if let imageView = self.imageView {
                self.addSubview(imageView)
            }
            
            // Set new title/image
            if let newTitle = newTitle {
                self.setTitle(newTitle, for: .normal)
            }
            
            if let newImage = newImage {
                self.setImage(newImage, for: .normal)
            }
            
            // Change background color
            self.backgroundColor = newBackgroundColor ?? self.backgroundColor
            
            // Should be unresponsive?
            self.isEnabled = !makeUnresponsive
        }
    }
    
    func setEnabled(_ isEnabled:Bool) {
        if isEnabled {
            enable()
        } else {
            disable()
        }
    }
    
    func enable() {
        self.isEnabled = true
        self.alpha = 1.0
    }
    
    func disable() {
        self.isEnabled = false
        self.alpha = 0.5
    }
    
    func setSelected(selectedBtn: UIButton, deSelectedBtn: UIButton) {
        
        self.selected(btn: selectedBtn)
        self.deSelected(btn: deSelectedBtn)
    }
    
    func selected(btn: UIButton) {
        btn.backgroundColor = UIColor.init(red: 255.0/255.0, green: 45.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        btn.setTitleColor(UIColor.white, for: .normal)
    }
    
    func deSelected(btn: UIButton) {
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(UIColor.init(red: 255.0/255.0, green: 45.0/255.0, blue: 40.0/255.0, alpha: 1.0), for: .normal)
    }
}

// CGSize
extension CGSize {
    
    // Get new size with `midWidth` and `midHeight`
    // - parameter factor: This is the factor that is used for division
    func midSize(factor: CGFloat = 2) -> CGSize {
        return CGSize(width: self.width/factor, height: self.height/factor)
    }
    
    // Get `CGPoint` that is the center of self size
    var center: CGPoint { return CGPoint(x: self.width/2, y: self.height/2) }
}

extension Data {
    
    public var hexString: String {
        return map { String(format: "%02.2hhx", arguments: [$0]) }.joined()
    }
}

extension String {
    
    var trim : String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    var length : Int {
        return self.count
    }
}

// Bundle
extension Bundle {
    var bundleShortVersion: String { return infoDictionary?["CFBundleShortVersionString"] as! String }
}

extension DateFormatter {
    
    func setLocal() {
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        self.locale = Locale.init(identifier: "en_US_POSIX")
    }
}

extension UIDatePicker {
    
    public var clampedDate: Date {
        let referenceTimeInterval = self.date.timeIntervalSinceReferenceDate
        let remainingSeconds = referenceTimeInterval.truncatingRemainder(dividingBy: TimeInterval(minuteInterval*60))
        let timeRoundedToInterval = referenceTimeInterval - remainingSeconds
        return Date(timeIntervalSinceReferenceDate: timeRoundedToInterval)
    }
    
    func set18YearValidation() {
        
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.year = -18
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        components.year = -150
        let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
        self.minimumDate = minDate
        self.maximumDate = maxDate
    }
}

extension String {
    
    func numberOfSeconds() -> Int {
        var components: Array = self.components(separatedBy: ":")
        if components.count == 2 {
            let hours = Int(components[0]) ?? 0
            let minutes = Int(components[1]) ?? 0
            return (hours * 3600) + (minutes * 60)
        } else {
            let hours = Int(components[0]) ?? 0
            let minutes = Int(components[1]) ?? 0
            let seconds = Int(components[2]) ?? 0
            return (hours * 3600) + (minutes * 60) + seconds
        }
    }
    
    func date(format: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: self)
        return date
    }
}

extension Date {
    
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
    
    var startOfDay: Date {
        
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.year, .month, .day])
        let components = calendar.dateComponents(unitFlags, from: self)
        return calendar.date(from: components)!
    }
    
    var endOfDay: Date {
        
        var components = DateComponents()
        components.day = 1
        let date = Calendar.current.date(byAdding: components, to: self.startOfDay)
        return (date?.addingTimeInterval(-1))!
    }
    
    var yesterday: Date {
        let calendar = Calendar.current
        return (calendar as NSCalendar).date(byAdding: .day, value: -1, to: Date(), options: .matchStrictly)!.dateWithNoTime()
    }
    
    public func dateWithNoTime()->Date{
        let calendar = Calendar.current
        let date = calendar.startOfDay(for: self)
        return date
    }
    
    func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
        
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(_ dateToCompare: Date) -> Bool {
        
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(_ dateToCompare: Date) -> Bool {
        
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
}
