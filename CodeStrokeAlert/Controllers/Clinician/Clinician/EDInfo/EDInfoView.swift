//
//  EDInfoView.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 25/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol EDInfoViewDelegate {
    
    func showAlert(withTitle title: String, andMessage message: String, isSuccess: Bool)
}

class EDInfoView: UIView {
    
    @IBOutlet var container: UIView!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var btnRegistered: UIButton!
    @IBOutlet weak var btnTriaged: UIButton!
    @IBOutlet weak var btnPrimarySurvey: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Delegate
    var delegate: EDInfoViewDelegate? = nil
    
    // Location Manager
    fileprivate var locationManager             = CLLocationManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initilize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initilize()
    }
    
    override var frame: CGRect {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.container.frame = self.bounds
    }
    
    func initilize() {
        
        Bundle.main.loadNibNamed(String(describing: EDInfoView.self), owner: self, options: nil)
        self.container.frame = self.bounds
        self.addSubview(self.container)
        self.clipsToBounds = true
        
        // Setup Submit Button With Gradient Image
        self.setGradientToButton(for: self.btnSubmit, with: 12.0)
        
        // Get ED Data
        self.getEDInfo()
    }
}

extension EDInfoView {
    
    func getEDInfo() {
        
        self.activityIndicator.startAnimating()
        
        NetworkModule.shared.getEDInfo(onSuccess: { apiResponseEDList in

            print(apiResponseEDList)
            EDManager.add(eds: apiResponseEDList.edArray)
            
            if let location = apiResponseEDList.edArray[0].location {
                self.txtLocation.text = location
            }
            
            if apiResponseEDList.edArray[0].primary_survey != 0 {
                self.btnPrimarySurvey.isSelected = true
            }
            
            if apiResponseEDList.edArray[0].registered != 0 {
                self.btnRegistered.isSelected = true
            }
            
            if apiResponseEDList.edArray[0].triaged != 0 {
                self.btnTriaged.isSelected = true
            }
        }, onFailure: { failureReason in
            print(failureReason)
        }, onAction: { responseAction in
        }, onError: { error in
        }, onComplete: { success in
            self.activityIndicator.stopAnimating()
        })
    }
}

// MARK:- Action Methods -
extension EDInfoView {
    
    @IBAction func btnEDOptionClicked(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        var strLocation = ""
        if let location = self.txtLocation.text {
            strLocation = location
        }
        
        self.activityIndicator.startAnimating()
        
        NetworkModule.shared.setEDInfo(location: strLocation, registered: self.btnRegistered.isSelected ? 1 : 0, triaged: self.btnTriaged.isSelected ? 1 : 0, primary_survey: self.btnPrimarySurvey.isSelected ? 1 : 0, onSuccess: { apiResponseEDList in
            
        }, onFailure: { failureReason in
        }, onAction: { responseAction in
        }, onError: { error in
        }, onComplete: { success in
            
            // Show Alert
            if success {
                self.delegate?.showAlert(withTitle: "CodeStrokeAlert", andMessage: "Submitted successfully", isSuccess: true)
            } else {
                self.delegate?.showAlert(withTitle: "CodeStrokeAlert", andMessage: "Error while submitting data", isSuccess: false)
            }
            
            self.activityIndicator.stopAnimating()
        })
    }
    
    @IBAction func btnLocationClicked(_ sender: UIButton) {
        
        // Start location manager
        self.locationManager.distanceFilter                     = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy                    = kCLLocationAccuracyBest
        self.locationManager.allowsBackgroundLocationUpdates    = true
        self.locationManager.delegate                           = self
        self.locationManager.startUpdatingLocation()
    }
}

// MARK:- CLLocationManagerDelegate -
extension EDInfoView: CLLocationManagerDelegate {
    
    /// Did update location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Check
        guard let location = locations.first else { return }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if (error != nil) {
                print("error in reverseGeocode")
            }
            
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0 {
                let placemark = placemarks![0]
                self.txtLocation.text = "\(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!)"
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

    }
}
