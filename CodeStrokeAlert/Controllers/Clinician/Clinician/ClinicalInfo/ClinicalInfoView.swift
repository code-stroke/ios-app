//
//  ClinicalInfoView.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 25/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit

protocol ClinicalInfoViewDelegate {
    
    func showAlert(withTitle title: String, andMessage message: String, isSuccess: Bool)
    func showDatePicker(actionController: RMDateSelectionViewController)
}

class ClinicalInfoView: UIView {

    @IBOutlet var container: UIView!
    
    @IBOutlet weak var txtPastMedicalHistory: UITextField!
    @IBOutlet weak var txtMedication: UITextField!
    @IBOutlet weak var txtLastDose: UITextField!
    @IBOutlet weak var txtSituation: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtLastMeal: UITextField!
    
    @IBOutlet weak var btnAnticoagulantsYes: UIButton!
    @IBOutlet weak var btnAnticoagulantsNo: UIButton!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var strLastDoseDate: String = ""
    var strLastMealDate: String = ""
    
    // Delegate
    var delegate: ClinicalInfoViewDelegate? = nil
    
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
        
        Bundle.main.loadNibNamed(String(describing: ClinicalInfoView.self), owner: self, options: nil)
        self.container.frame = self.bounds
        self.addSubview(self.container)
        self.clipsToBounds = true
        
        // Setup Submit Button With Gradient Image
        self.setGradientToButton(for: self.btnSubmit, with: 12.0)
        
        // Delegate
        self.txtLastDose.delegate = self
        self.txtLastMeal.delegate = self
        
        // Get ED Data
        self.getClinicalInfo()
    }
}

extension ClinicalInfoView {
    
    func getClinicalInfo() {
        
        self.activityIndicator.startAnimating()
        
        NetworkModule.shared.getClinicalInfo(onSuccess: { apiResponseClinicalInfo in
            print(apiResponseClinicalInfo)
            
            self.txtWeight.text = "\(apiResponseClinicalInfo.clinicalInfoArray[0].weight)"
            self.txtLastDose.text =  apiResponseClinicalInfo.clinicalInfoArray[0].anticoags_last_dose ?? ""
            self.txtLastMeal.text = apiResponseClinicalInfo.clinicalInfoArray[0].last_meal ?? ""
            self.txtSituation.text = apiResponseClinicalInfo.clinicalInfoArray[0].hopc ?? ""
            self.txtMedication.text = apiResponseClinicalInfo.clinicalInfoArray[0].meds ?? ""
            self.txtPastMedicalHistory.text = apiResponseClinicalInfo.clinicalInfoArray[0].pmhx ?? ""
            
            if let strLastDose = apiResponseClinicalInfo.clinicalInfoArray[0].anticoags_last_dose {
                
                self.strLastDoseDate = strLastDose
            }
            
            if let strLastMeal = apiResponseClinicalInfo.clinicalInfoArray[0].last_meal {
                
                self.strLastMealDate = strLastMeal
            }
            
            self.btnAnticoagulantsYes.isSelected = false
            self.btnAnticoagulantsNo.isSelected = true
            
            if let anticoags = apiResponseClinicalInfo.clinicalInfoArray[0].anticoags {
                
                if anticoags == "unknown" {
                    
                    self.btnAnticoagulantsYes.isSelected = false
                    self.btnAnticoagulantsNo.isSelected = false
                } else if anticoags == "no" {
                    
                    self.btnAnticoagulantsYes.isSelected = false
                    self.btnAnticoagulantsNo.isSelected = true
                } else {
                    
                    self.btnAnticoagulantsYes.isSelected = true
                    self.btnAnticoagulantsNo.isSelected = false
                }
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
extension ClinicalInfoView {
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        var strWeight = "0"
        
        if isEmptyString(self.txtWeight.text!) {
            strWeight = "0"
        } else {
            strWeight = self.txtWeight.text!.trim
        }
        
        self.activityIndicator.startAnimating()
        
        NetworkModule.shared.setClinicalInfo(pmhx: self.txtPastMedicalHistory.text!, anticoags_last_dose: self.strLastDoseDate, meds: self.txtMedication.text!, anticoags: self.btnAnticoagulantsYes.isSelected ? true : false, hopc: self.txtSituation.text!, weight: Float(strWeight)!, last_meal: self.strLastMealDate, onSuccess: { apiResponseClinicalInfo in
    
            print(apiResponseClinicalInfo)
            
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
    
    @IBAction func btnAnticoagulantsClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnAnticoagulantsYes, self.btnAnticoagulantsNo], selectedButton: sender)
    }
}

// MARK:- Custom Methods -
private extension ClinicalInfoView {
    
    func clearAllAndSelected(buttons: [UIButton], selectedButton: UIButton) {
        
        buttons.forEach { $0.isSelected = false }
        selectedButton.isSelected = true
    }
    
    func openDatePicker() {
        
        self.endEditing(true)
        let style = RMActionControllerStyle.white
        
        let cancelAction = RMAction<UIDatePicker>(title: "Cancel", style: RMActionStyle.cancel) { _ in
            
            print("Date selection was canceled")
        }
        
        let selectAction = RMAction<UIDatePicker>(title: "Select", style: RMActionStyle.done) { controller in
            
            if let pickerController = controller as? RMDateSelectionViewController {
                
                let f = DateFormatter()
                
                if self.txtLastMeal.isSelected == true {
                    
                    f.dateFormat = "yyyy-MM-dd hh:mm"
                    let formattedDate: String = f.string(from: pickerController.datePicker.date)
                    self.txtLastMeal.text = formattedDate
                    
                    f.setLocal()
                    f.dateFormat = "yyyy-MM-dd hh:mm:ss"
                    self.strLastMealDate = f.string(from: pickerController.datePicker.date)
                    
                } else {
                    
                    f.dateFormat = "yyyy-MM-dd hh:mm"
                    let formattedDate: String = f.string(from: pickerController.datePicker.date)
                    self.txtLastDose.text = formattedDate
                    
                    f.setLocal()
                    f.dateFormat = "yyyy-MM-dd hh:mm:ss"
                    self.strLastDoseDate = f.string(from: pickerController.datePicker.date)
                }
            }
        }
        
        let actionController = RMDateSelectionViewController(style: style, title: "Please select date", message: nil, select: selectAction, andCancel: cancelAction)!
        
        actionController.datePicker.datePickerMode = .dateAndTime
        
        self.delegate?.showDatePicker(actionController: actionController)
    }
}

// MARK:- TextField Delegate -
extension ClinicalInfoView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == txtLastMeal {
            
            self.txtLastDose.isSelected = false
            self.txtLastMeal.isSelected = true
            self.openDatePicker()
            return false
            
        } else if textField == txtLastDose {
            
            self.txtLastDose.isSelected = true
            self.txtLastMeal.isSelected = false
            self.openDatePicker()
            return false
        }
        return true
    }
}
