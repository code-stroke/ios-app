//
//  HospitalViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 06/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit
import CoreLocation

private var selectorColorAssociationKey: UInt8 = 0

extension UIPickerView {
    
    @IBInspectable var selectorColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &selectorColorAssociationKey) as? UIColor
        }
        set(newValue) {
            objc_setAssociatedObject(self, &selectorColorAssociationKey, newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    open override func didAddSubview(_ subview: UIView) {
        
        super.didAddSubview(subview)
        if let color = selectorColor {
            if subview.bounds.height < 1.0 {
                subview.backgroundColor = color
            }
        }
    }
}


// MARK:- Outlets and Properties -
class HospitalViewController: BaseViewController {

    // Outlets
    @IBOutlet weak var btnNext: RoundedButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var viewTop: UIView!
    
    var selectedHospital: Int = 0
    var userCurrentLocation: CLLocation?
}

// MARK:- ViewController LifeCycle -
extension HospitalViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Initialize
        self.initialise(withNavBarStyle: .standard, leftNavBarButtonType: .back, rightNavBarButtonType: .none, customImage: #imageLiteral(resourceName: "ic_logo.png"))
        
        // Call Setup Method
        self.setup()
    }
}

// MARK:- Action Methods -
extension HospitalViewController {
    
    @IBAction func btnNextClicked(_ sender: UIButton) {
        
        let pastMedicalHistoryVC: PastMedicalHistoryViewController = UIStoryboard.storyboard(.medical).instantiate()
        self.navigate(to: pastMedicalHistoryVC)
    }
}

// MARK:- Private Extension -
fileprivate extension HospitalViewController {
    
    func setup() {
        
        self.updateUserCurrentLocation()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notificationObject:)), name: NSNotification.Name(rawValue: BaseViewController.notificationIdentifier), object: nil)
        
        self.title = "Destination"
        
        viewTop.layer.shadowColor = UIColor.lightGray.cgColor
        viewTop.layer.shadowOpacity = 1
        viewTop.layer.shadowOffset = CGSize.zero
        viewTop.layer.cornerRadius = 3.0
        viewTop.layer.shadowRadius = 10
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        let image1 = self.gradientWithFrametoImage(frame: btnNext.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnNext.backgroundColor = UIColor(patternImage: image1)
    }
    
    @objc func methodOfReceivedNotification(notificationObject: Notification){
        
        print(notificationObject.userInfo ?? "not found location")
        userCurrentLocation = notificationObject.userInfo?["location"] as? CLLocation
    }
}

// MARK: - Picker Controller Delegate -
extension HospitalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView:  UIPickerView) -> Int  {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Austin"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedHospital = row
    }
}
