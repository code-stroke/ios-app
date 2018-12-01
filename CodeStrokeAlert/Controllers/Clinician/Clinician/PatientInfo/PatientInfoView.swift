//
//  PatientInfoView.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 25/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import UIKit

protocol PatientInfoViewDelegate {
    
    func showAlert(withTitle title: String, andMessage message: String, isSuccess: Bool)
}

class PatientInfoView: UIView {
    
    @IBOutlet var container: UIView!
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtLastWell: UITextField!
    @IBOutlet weak var txtNextKin: UITextField!
    @IBOutlet weak var txtNOKContact: UITextField!
    @IBOutlet weak var txtMedicare: UITextField!
    
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnUnspecified: UIButton!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Delegate
    var delegate: PatientInfoViewDelegate? = nil
    
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
        
        Bundle.main.loadNibNamed(String(describing: PatientInfoView.self), owner: self, options: nil)
        self.container.frame = self.bounds
        self.addSubview(self.container)
        self.clipsToBounds = true
        
        // Setup Submit Button With Gradient Image
        self.setGradientToButton(for: self.btnSubmit, with: 12.0)
        
        // Get ED Data
        self.getPatientInfo()
    }
}

extension PatientInfoView {
    
    func getPatientInfo() {
        
        self.activityIndicator.startAnimating()
        
        NetworkModule.shared.getPatientInfo(onSuccess: { apiResponsePatientInfo in
            print(apiResponsePatientInfo)
            
            self.txtAddress.text = apiResponsePatientInfo.caseArray[0].address
            self.txtDob.text = apiResponsePatientInfo.caseArray[0].dob
            self.txtNextKin.text = apiResponsePatientInfo.caseArray[0].nok
            self.txtSurname.text = apiResponsePatientInfo.caseArray[0].last_name
            self.txtLastWell.text = apiResponsePatientInfo.caseArray[0].last_well
            self.txtMedicare.text = apiResponsePatientInfo.caseArray[0].medicare_no
            self.txtFirstName.text = apiResponsePatientInfo.caseArray[0].first_name
            self.txtNOKContact.text = apiResponsePatientInfo.caseArray[0].nok_phone
            
            self.btnFemale.isSelected = false
            self.btnMale.isSelected = false
            self.btnUnspecified.isSelected = false
            
            if apiResponsePatientInfo.caseArray[0].gender == "f" {
                self.btnFemale.isSelected = true
            } else if apiResponsePatientInfo.caseArray[0].gender == "m" {
                self.btnMale.isSelected = true
            } else {
                self.btnUnspecified.isSelected = true
            }
        }, onFailure: { failureReason in
        }, onAction: { responseAction in
        }, onError: { error in
        }, onComplete: { success in
            self.activityIndicator.stopAnimating()
        })
    }
}

// MARK:- Action Methods -
extension PatientInfoView {
    
    @IBAction func btnGenderClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnMale, self.btnFemale, self.btnUnspecified], selectedButton: sender)
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        self.activityIndicator.startAnimating()
        
        NetworkModule.shared.setPatientInfo(first_name: self.txtFirstName.text!, last_name: self.txtSurname.text!, dob: "", address: self.txtAddress.text!, gender: self.btnUnspecified.isSelected ? "u" : (self.btnMale.isSelected ? "m" : "f"), last_well: "", nok: self.txtNextKin.text!, nok_phone: self.txtNOKContact.text!, medicare_no: self.txtMedicare.text!, hospital_id: "1", onSuccess: { apiResponsePatientInfo in
            
            print(apiResponsePatientInfo)
            
        }, onFailure: { failureReason in
            
            // Switch failure reason
            if failureReason == .wrongCredentials {
                print(failureReason)
            }
            
        }, onAction: { responseAction in
            
            // Show alert for response action
            if responseAction == .actionUpdate {
                
            }
            
        }, onError: { error in
            // Show alert for error
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
}

// MARK:- Custom Methods -
private extension PatientInfoView {
    
    func clearAllAndSelected(buttons: [UIButton], selectedButton: UIButton) {
        
        buttons.forEach { $0.isSelected = false }
        selectedButton.isSelected = true
    }
}
