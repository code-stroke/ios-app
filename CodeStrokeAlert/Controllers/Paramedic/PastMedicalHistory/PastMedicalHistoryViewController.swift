//
//  PastMedicalHistoryViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 07/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit
import EVReflection

class ClinicalHistoryData: EVObject {
    
    var strPostMedicalHistory: String           = ""
    var strMedications: String                  = ""
    var strAnticoagulants: Bool                 = false
    var strLastDostDate: String                 = ""
    var strSituation: String                    = ""
    var strWeight: Float                        = 0.0
}

// MARK:- Outlets and Properties -
class PastMedicalHistoryViewController: BaseViewController {

    @IBOutlet weak var btnNext: RoundedButton!
    
    @IBOutlet weak var txtPastMedicalHistory: UITextField!
    @IBOutlet weak var btnIHD: UIButton!
    @IBOutlet weak var btnDM: UIButton!
    @IBOutlet weak var btnStroke: UIButton!
    @IBOutlet weak var btnEpilepsy: UIButton!
    @IBOutlet weak var btnAF: UIButton!
    @IBOutlet weak var btnOther: UIButton!
    
    @IBOutlet weak var txtMedications: UITextField!
    @IBOutlet weak var btnAnticoagulantsYes: UIButton!
    @IBOutlet weak var btnAnticoagulantsNo: UIButton!
    @IBOutlet weak var btnAnticoagulantsUnknown: UIButton!
    
    @IBOutlet weak var btnApixaban: UIButton!
    @IBOutlet weak var btnRivaroxaban: UIButton!
    @IBOutlet weak var btnWarfarin: UIButton!
    @IBOutlet weak var btnDabigatran: UIButton!
    @IBOutlet weak var btnHeparin: UIButton!
    
    @IBOutlet weak var txtLastDate: UITextField!
    @IBOutlet weak var txtSituation: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    
    var strLastMealDate: String = ""
    
    var clinicalHistoryData = ClinicalHistoryData()
}

// MARK:- ViewController LifeCycle -
extension PastMedicalHistoryViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Initialize
        self.initialise(withNavBarStyle: .standard, leftNavBarButtonType: .back, rightNavBarButtonType: .none, customImage: #imageLiteral(resourceName: "ic_logo.png"))
        
        // Setup
        self.setup()
    }
}

// MARK:- Actoin Methods -
extension PastMedicalHistoryViewController {
    
    @IBAction func btnPostMedicalHistoryClicked(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    @IBAction func btnAnnticoagulantsClicked(_ sender: UIButton) {
        
        self.btnAnticoagulantsYes.isSelected = false
        self.btnAnticoagulantsNo.isSelected = false
        sender.isSelected = true
    }
    
    @IBAction func btnMedicationClicked(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    @IBAction func btnNextClicked(_ sender: UIButton) {
        
        var strPostMdHistory = ""
        
        if !isEmptyString(self.txtPastMedicalHistory.text!) {
            strPostMdHistory = self.txtPastMedicalHistory.text!.trim
            strPostMdHistory.append(",")
        }
        
        if btnIHD.isSelected {
            strPostMdHistory.append("IHD,")
        }
        if btnDM.isSelected {
            strPostMdHistory.append("DM,")
        }
        if btnStroke.isSelected {
            strPostMdHistory.append("Stroke,")
        }
        if btnEpilepsy.isSelected {
            strPostMdHistory.append("Epilepsy,")
        }
        if btnAF.isSelected {
            strPostMdHistory.append("AF,")
        }
        if btnOther.isSelected {
            strPostMdHistory.append("Other neurological conditions")
        }
        
        if strPostMdHistory.last == "," {
            strPostMdHistory = String(strPostMdHistory.dropLast())
        }
        
        var strMedication = ""
        
        if isEmptyString(self.txtMedications.text!) {
            strMedication = ""
        } else {
            strMedication = self.txtMedications.text!.trim
        }
        
        var strSituation = ""
        
        if isEmptyString(self.txtSituation.text!) {
            strSituation = ""
        } else {
            strSituation = self.txtSituation.text!.trim
        }
        
        var strWeight = "0"
        
        if isEmptyString(self.txtWeight.text!) {
            strWeight = "0"
        } else {
            strWeight = self.txtWeight.text!.trim
        }
        
        clinicalHistoryData.strPostMedicalHistory = strPostMdHistory
        clinicalHistoryData.strMedications = strMedication
        clinicalHistoryData.strAnticoagulants = self.btnAnticoagulantsYes.isSelected ? true : false
        clinicalHistoryData.strLastDostDate = strLastMealDate
        clinicalHistoryData.strSituation = strSituation
        clinicalHistoryData.strWeight = Float(strWeight)!

        let arrValues: [String: String] = ["Past Medical History": clinicalHistoryData.strPostMedicalHistory,
                                           "Medications": clinicalHistoryData.strMedications,
                                           "Anticoagulants": clinicalHistoryData.strAnticoagulants ? "Yes" : "No",
                                           "Last Dose": clinicalHistoryData.strLastDostDate,
                                           "Situation (HOPC)": clinicalHistoryData.strSituation,
                                           "Weight": "\(clinicalHistoryData.strWeight)"]
        
        var cellValue: [CellValues] = []
        
        arrValues.forEach { arrVal in
            let cell = CellValues()
            cell.title = arrVal.key
            cell.value = arrVal.value
            cellValue.append(cell)
        }
        
        let sectionItem = SectionedItem(title: "History", values: cellValue)
        sectionedItems.append(sectionItem)
        
        NetworkModule.shared.setClinicalHistory(pmhx: strPostMdHistory, meds: strMedication, anticoags: self.btnAnticoagulantsUnknown.isSelected ? "unknown" : (self.btnAnticoagulantsYes.isSelected ? "yes" : "no"), hopc: strSituation, weight: Float(strWeight)!, last_meal: strLastMealDate, onSuccess: { apiResponseClinicalInfo in
            
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
                // Create Alert Controller
                let alertController = PGAlertViewController(title: "CodeStrokeAlert", message: "Submitted successfully", style: .success, dismissable: false, actions: [PGAlertAction(title: "OK", style: .normal, handler: {
                    
                    let massVC: MassViewController = UIStoryboard.storyboard(.mass).instantiate()
                    self.navigate(to: massVC)
                    
                }) ])
                
                // Show alert controller
                self.present(alertController, animated: true, completion: nil)
            } else {
                
                // Create Alert Controller
                let alertController = PGAlertViewController(title: "CodeStrokeAlert", message: "Error while submitting data", style: .error, dismissable: true, actions: [PGAlertAction(title: "OK", style: .normal, handler: {
                    
                }) ])
                
                // Show alert controller
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
}

// MARK:- Private Methods -
fileprivate extension PastMedicalHistoryViewController {
    
    func setup() {
        
        let image1 = self.gradientWithFrametoImage(frame: btnNext.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnNext.backgroundColor = UIColor(patternImage: image1)
    }
}

// MARK: - UITextField Delegate -
extension PastMedicalHistoryViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        
        // Create a date picker for the date field.
        let picker = UIDatePicker()
        picker.addTarget(self, action: #selector(updateDateField(sender:)), for: .valueChanged)
        textField.inputView = picker
        
        picker.datePickerMode = .dateAndTime
        
        // If the date field has focus, display a date picker instead of keyboard.
        // Set the text to the date currently displayed by the picker.
        textField.text = formatDateForDisplay(date: picker.date)
    }
}

// MARK:- Public Methods -
extension PastMedicalHistoryViewController {
    
    // Called when the date picker changes.
    @objc func updateDateField(sender: UIDatePicker) {
        
        let f = DateFormatter()
        
        f.dateFormat = "MMM dd, yyyy"
        let formattedDate: String = f.string(from: sender.date)
        self.txtLastDate.text = formattedDate
        
        f.setLocal()
        f.dateFormat = "yyyy-MM-dd hh:mm:ss"
        self.strLastMealDate = f.string(from: sender.date)
    }
    
    // Formats the date chosen with the date picker.
    func formatDateForDisplay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
}
