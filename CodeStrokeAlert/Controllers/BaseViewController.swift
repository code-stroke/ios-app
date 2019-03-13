//
//  BaseViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 04/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit
import CoreLocation
import RxSwift

/// Enum for navigation bar style
internal enum NavigationBarStyle {
    
    // Navigation bar is hidden
    case none
    
    // Navigation bar has standard height (44px)
    case standard
}

/// Enum for left bar button type
internal enum LeftNavigationBarButtonType {
    
    // Left navigation bar button is not present
    case none
    
    // Left navigation bar button is the back button
    case back
    
    // Left navigation bar button is the close button (X)
    case close
}

/// Enum for right bar button type
internal enum RightNavigationBarButtonType {
    
    // Right navigation bar button is not present
    case none
    
    // Right navigation bar button is the close button (X)
    case close
    
    // Right navigation bar button is the search button
    case search
    
    // Left navigation bar button is the add button (+) for adding paramedic
    case add
}

// MARK:- Properties -
class BaseViewController: UIViewController {

    // MARK:- Declaration -
    
    // DisposeBag for RxSwift (i.e.: RxKeyboard)
    internal var disposeBag = DisposeBag()
    
    // Location Manager
    var locationManager: CLLocationManager?
    static let notificationIdentifier: String = "UserLocation"
    var isFirstTime: Bool?
    
    // StatusBar behaviour
    private var _statusBarStyle: UIStatusBarStyle = .default
    private var _statusBarAnimation: UIStatusBarAnimation = .slide
    private var _statusBarHidden: Bool = false
    
    // Overrides StatusBar vars
    override var preferredStatusBarStyle: UIStatusBarStyle { return self._statusBarStyle }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { return self._statusBarAnimation }
    override var prefersStatusBarHidden: Bool { return self._statusBarHidden }
    
    // Default is `.standard`
    private var navBarStyle: NavigationBarStyle = .standard
    
    // Left navigation bar button, Default is `.none`
    private var leftNavBarButtonType: LeftNavigationBarButtonType = .none
    
    // Right navigation bar button, Default is `.none`
    private var rightNavBarButtonType: RightNavigationBarButtonType = .none
    
    // Hide default initialisers
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Custom initialisers, Init with given navBarStyle and leftNavBarButtonType
    internal func initialise(withNavBarStyle navBarStyle: NavigationBarStyle = .standard,
                             leftNavBarButtonType: LeftNavigationBarButtonType = .none,
                             rightNavBarButtonType: RightNavigationBarButtonType = .none,
                             customTitle: String? = nil,
                             customImage: UIImage? = nil) {
        
        // Set styles
        self.navBarStyle = title == nil ? navBarStyle : .standard
        self.leftNavBarButtonType = leftNavBarButtonType
        self.rightNavBarButtonType = rightNavBarButtonType
        
        // Build UI
        self.buildViewController(customTitle: customTitle, customImage: customImage)
    }
}

// MARK:- ViewController LifeCycle -
extension BaseViewController {
    
    /// ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set backgrounds color
        self.navigationController?.view.backgroundColor = .white
        self.view.backgroundColor = .white

        // Update constraints values
        self.updateConstraintsValues()
    }
    
    /// ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    /// Override view will disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Hide navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK:- Public Methods -
extension BaseViewController {
    
    func showAlert(for message: String) {
        
        // Create controller
        let alertController = PGAlertViewController(title: "CodeStrokeAlert", message: message, style: .warning, dismissable: true, actions: [PGAlertAction(title: "OK", style: .normal, handler: {
            
        }) ])
        
        // Show alert controller
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK:- Private Methods -
fileprivate extension BaseViewController {
    
    /// Build UI based on given parameters
    func buildViewController(customTitle: String? = nil, customImage: UIImage? = nil) {
        
        // Get navigation bar
        if let navBar = self.navigationController?.navigationBar {
            
            // Set navBar custom background color
            navBar.setBackgroundImage(nil, for: .any, barMetrics: .default)
            navBar.shadowImage = nil
            navBar.isTranslucent = false
        }
        
        switch self.leftNavBarButtonType {
        
        case .back:
            
            // Show back button
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .plain, target: self, action: #selector(self.backButtonTapped))
            
        case .close:
            
            // Show close button
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Cross lines"), style: .plain, target: self, action: #selector(self.backButtonTapped))
        
        case .none:
            
            // Don't show any button
            self.navigationItem.leftBarButtonItem = nil
        }
        
        switch self.rightNavBarButtonType {

        case .close:
            
            // Show close button
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Cross lines"), style: .plain, target: self, action: #selector(self.dismiss(animated:completion:)))
            
        case .search:
            
            // Show search button
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_search.png"), style: .plain, target: self, action: #selector(self.searchButtonTapped))
            
        case .add:
            
            // Show add button
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addParamedicButtonTapped))
            
        case .none:
            
            // Don't show any button
            self.navigationItem.rightBarButtonItem = nil
        }
        
        // Add title view
        if let customTitle = customTitle {
            
            // Set text as title view
            self.navigationItem.titleView = self.createNavigationBarTitleView(withTitle: customTitle, forFrame: self.navigationItem.titleView?.frame)
            
        }
        
        // If `customImage` is setted,
        // NOTICE: `customImage` will repleace `customTitle` if both are provided.
        if let customImage = customImage {
            
            // Set image as title view
            self.navigationItem.titleView = self.createNavigationBarTitleView(withImage: customImage)
            
        } else {
            
            // Check for logoImage
            if let logoImage = UIImage(named: "ic_logo") {
                
                // Set logo as navigation bar title's view
                self.navigationItem.titleView = self.createNavigationBarTitleView(withImage: logoImage)
            } else {
                
                // Set text as title view
                self.navigationItem.titleView = self.createNavigationBarTitleView(withTitle: "Code Stroke Alert", forFrame: self.navigationItem.titleView?.frame)
            }
        }
        
        // Set `tintColor`
        self.navigationItem.leftBarButtonItems?.forEach({
            $0.tintColor = UIColor.orange
        })
        
        // If `navigationItem.rightBarButtonItem` is not nil, set `tintColor`
        self.navigationItem.rightBarButtonItems?.forEach({
            $0.tintColor = UIColor.orange
        })
    }
}

// MARK:- BaseViewController extension to show another controller -
extension BaseViewController {
    
    /// Go back on back button tap
    @objc func backButtonTapped() {
        
        // Check for navigation controller
        guard let navController = self.navigationController else {
            // Just dismiss
            self.dismiss(animated: true, completion: nil)
            return
        }
        navController.popViewController(animated: true)
    }
    
    /// Move to Paramedic work flow on add button tap
    @objc func addParamedicButtonTapped() {
        
        // Go to paramedic work flow
        let paramedicNavigation: ParamedicNavigationController = UIStoryboard.storyboard(.patientdetail).instantiate()
        self.present(paramedicNavigation, animated: true, completion: nil)
    }
    
    /// Back to main view controller
    func loadMainViewController() {
        
        // Go back to root view controller
        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard.storyboard(.main).instantiateInitialViewController()
    }
    
    /// Navigate to passed controller
    func navigate(to controller: UIViewController?, animated: Bool = true, completion: (() -> Void)? = nil) {
        
        // Check for valid controller
        guard let controller = controller else { return }
        
        // If in navigation controller, then push
        if let navController = self.navigationController {
            navController.pushViewController(controller, animated: animated)
        } else {
            // Show from self
            self.present(controller, animated: animated, completion: completion)
        }
    }
    
    /// This function will be called on `searchIcon` button press (navigation bar only)
    @objc internal func searchButtonTapped() {
        
        // Do things...
    }
    
    /// This function is automatically called during `viewDidLoad` function, but if you need you can re-call it manually.
    internal func updateConstraintsValues() {
        // `setNeedsLayout`
        self.view.setNeedsLayout()
    }
}

// MARK:- BaseViewController functions to create needed elements (like navigation bar's title view) -
extension BaseViewController {
    
    /// Create an UILabel with custom font to use as `UINavigationBar` title's view
    func createNavigationBarTitleView(withTitle title: String?, forFrame frame: CGRect? = nil) -> UILabel? {
        
        // Check for title
        guard let title = title else { return nil }
        
        // Create label
        let label = UILabel(frame: frame ?? self.navigationController?.navigationBar.frame ?? .zero)
        label.numberOfLines = 1
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.sizeToFit()
        
        // Return customnized label
        return label
    }
    
    /// Create an UIImageView with custom logo to use as `UINavigationBar` title's view
    func createNavigationBarTitleView(withImage image: UIImage?) -> UIImageView? {
        
        // Check for image
        guard let image = image else { return nil }
        
        // Create image view
        let imageView = UIImageView(image: image)
        let height: CGFloat = 33
        let width: CGFloat = (image.size.width * height) / image.size.height
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        imageView.contentMode = .scaleAspectFit
        
        // Return image view
        return imageView
    }
}

// MARK:- BaseViewController extension for Status Bar updates -
extension BaseViewController {
    
    /// Set Status Bar hidden or visible
    /// - parameter hidden: This indicates if the status bar should be visible or not
    /// - parameter animation: This is the status bar update animation style (default is `.slide`)
    func setStatusBarHidden(_ hidden: Bool, animation: UIStatusBarAnimation = .slide) {
        
        // Change self vars
        self._statusBarHidden = hidden
        self._statusBarAnimation = animation
        
        // Animate and update
        UIView.animate(withDuration: 0.3, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
    
    /// Set Status Bar style
    /// - parameter style: This will be the new status bar style
    /// - parameter animation: This is the status bar update animation style (default is `.slide`)
    func setStatusBarStyle(_ style: UIStatusBarStyle, animation: UIStatusBarAnimation = .slide) {
        
        // Change self vars
        self._statusBarStyle = style
        self._statusBarAnimation = animation
        
        // Animate and update
        UIView.animate(withDuration: 0.3, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
}

// MARK:- Location Manager -
extension BaseViewController: CLLocationManagerDelegate {
    
    // MARK:- Get User Current Location -
    internal func updateUserCurrentLocation() {
        
        isFirstTime = true
        
        self.locationManager = CLLocationManager()
        
        guard let locationManager = self.locationManager else {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // you have 2 choice
            // 1. requestAlwaysAuthorization
            // 2. requestWhenInUseAuthorization
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // The accuracy of the location data
        locationManager.distanceFilter = 200 // The minimum distance (measured in meters) a device must move horizontally before an update event is generated.
        locationManager.delegate = self
    }
    
    // MARK:- CLLocationManagerDelegate -
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        
        if let firstTime = isFirstTime, firstTime == true {
            print(firstTime)
            self.stopUpdatingUserLocation(objectLocation: location)
        }
    }
    
    internal func stopUpdatingUserLocation(objectLocation:CLLocation) {
        
        self.locationManager?.stopUpdatingLocation()
        isFirstTime = false
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: BaseViewController.notificationIdentifier), object: nil, userInfo: ["location": objectLocation])
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
            
        case .notDetermined:
            print("not determined")
        case .authorizedWhenInUse:
            self.locationManager?.startUpdatingLocation()
            print("authorizedWhenInUse")
        case .denied:
            self.showAlertWithMessageAndActions(message: "Your device's positioning system is disabled. It is essential to determine your position.")
            print("denied")
        case .restricted:
            print("restricted")
        case .authorizedAlways:
            print("authorizedAlways")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // do on error
        print(error)
    }
    
    // MARK:- Alert Methods -
    internal func showAlertWithMessageAndActions(message title: String) {
        
        let alertController = UIAlertController(title: "CodeStrokeAlert", message: title, preferredStyle:UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default)
        { action -> Void in
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        { action -> Void in
            // Put your code here
        })
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil) // present the alert
        }
    }
}
