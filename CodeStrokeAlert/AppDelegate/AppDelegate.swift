//
//  AppDelegate.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 29/09/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import OneSignal
import Firebase
import UserNotifications
import CoreLocation
import Buglife

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let appID = "a704a88e-9e37-41f6-99b8-6ded41926c03"
    var deviceTokenString = "123"
    var Case_ID = 0
    var arrForGroupMembers = [String]()
    var locationManager: CLLocationManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        
        Buglife.shared().start(withEmail: "apps.jaypatel@gmail.com")
        
        // Location Manager
        self.locationManager = CLLocationManager()
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            self.locationManager?.requestWhenInUseAuthorization()
        }
        
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest // The accuracy of the location data
        self.locationManager?.distanceFilter = 200 // The minimum distance (measured in meters) a device must move horizontally before an update event is generated.
        self.locationManager?.delegate = self

        //Firebase
        FirebaseApp.configure()
        
        registerForPushNotifications()
        
        if let launchOptions = launchOptions {
            
            if let userInfo = launchOptions[UIApplication.LaunchOptionsKey.remoteNotification] as? [AnyHashable : Any] {
                
                let (title, body) = self.getAlert(notification: userInfo as [NSObject : AnyObject])
                print("\(title),\(body)")
                self.Case_ID = title
            }
        }
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: appID,
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CodeStrokeAlert")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK:- Notification Delegate -
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func registerForPushNotifications() {
        
        if #available(iOS 10.0, *) {
            
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {(granted, error) in
                if (granted) {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                } else {
                    
                }
            })
        } else {
            let type: UIUserNotificationType = [.badge, .alert, .sound]
            let setting = UIUserNotificationSettings(types: type, categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        deviceTokenString = deviceToken.hexString
        NSLog("LNDeviceToken: %@", deviceTokenString)
        
        if deviceTokenString.length > 0 {
            setDeviceToken(deviceTokenString)
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        let message = "didFailToRegisterForRemoteNotificationsWithError: " + error.localizedDescription
        print(message)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
//        if LoginUserData.savedUser()!.strUserType == "Paramedic" {
//            
//        } else {
//            updateDetail(with: userInfo, completionHandler)
//        }
    }
    
    func updateDetail(with userInfo: [AnyHashable : Any], _ completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let (title, body) = self.getAlert(notification: userInfo as [NSObject: AnyObject])
        print("\(title),\(body)")
        self.Case_ID = title
    }
    
    private func getAlert(notification: [NSObject:AnyObject]) -> (Int, Int) {
        
        let aps = notification["custom" as NSString] as? [String:AnyObject]
        print(aps!)
        let alert = aps?["a"] as? [String:AnyObject]
        print(alert!)
        let title = alert?["case_id"] as! Int
        return (title, title)
    }
}

// MARK:- Location Manager Delegate -
extension AppDelegate: CLLocationManagerDelegate {
    
    // MARK:- LocationManager Delegate -
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        print(location)
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
}

// MARK:- Custom Methods -
extension AppDelegate {
    
    func showAlertWithMessageAndActions(message title: String) {
        
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
            self.window?.rootViewController!.present(alertController, animated: true, completion: nil) // present the alert
        }
    }
}
