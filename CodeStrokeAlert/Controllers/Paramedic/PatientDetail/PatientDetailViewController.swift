//
//  PatientDetailViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 04/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit
import EVReflection

var sectionedItems: [SectionedItem] = []

class SectionedItem {
    
    var title: String? = nil
    var sectionedValues: [CellValues] = []
    
    init(title: String, values: [CellValues]) {
        self.title = title
        self.sectionedValues = values
    }
}

class PatientDetailData: EVObject {
    
    var strFirstName: String            = ""
    var strLastName: String             = ""
    var strName: String                 = ""
    var strAge: String                  = ""
    var strGender: String               = ""
    var strAddress: String              = ""
    var strLastSeen: String             = ""
    var strNok: String                  = ""
    var strNOKContact: String           = ""
}

// MARK:- Outlets and Properties -
class PatientDetailViewController: BaseViewController {

    // Outlets
    // Firstname
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var btnFirstNameUnknown: RoundedButton!
    
    // Surname
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var btnSurnameUnknown: RoundedButton!
    
    // DOB
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var btnDOBUnknown: RoundedButton!
    
    // Address
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var btnAddressUnknown: RoundedButton!
    
    // Gender
    @IBOutlet weak var segmentGender: UISegmentedControl!
    @IBOutlet weak var btnGenderUnspecified: RoundedButton!
    
    // Last Seen
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblMins: UILabel!
    @IBOutlet weak var lblAMPM: UILabel!
    @IBOutlet weak var txtLastSeen: UITextField!
    @IBOutlet weak var btnDateUnknown: RoundedButton!
    
    // Next to Kin
    @IBOutlet weak var txtNextToKIN: UITextField!
    @IBOutlet weak var btnNextToKINUnknown: RoundedButton!
    
    // NOK Phone
    @IBOutlet weak var txtNOKTelephone: UITextField!
    @IBOutlet weak var btnNOKTelephoneUnknown: RoundedButton!
    
    // Scan Licence
    @IBOutlet weak var btnScanLicense: UIButton!
    
    // Next
    @IBOutlet weak var btnNext: RoundedButton!
    
    // Private variables
    fileprivate var strDOB: String = ""
    fileprivate var strLastSeen: String = ""
    fileprivate var patientDetailData = PatientDetailData()
    fileprivate var activeTextField: UITextField? = nil
    
    // ViewModel
    var viewModel: PatientDetailViewControllerViewModel!
}

// MARK:- ViewController LifeCycle -
extension PatientDetailViewController {
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Initialize
        self.initialise(withNavBarStyle: .standard, leftNavBarButtonType: .back, rightNavBarButtonType: .none, customImage: #imageLiteral(resourceName: "ic_logo.png"))
        
        // Initialize the ViewModel
        self.viewModel = PatientDetailViewControllerViewModelImplementation(self)
        
        // Call Setup Method
        self.setup()
    }
    
    override func backButtonTapped() {
        self.dismiss(animated: true) {
            
        }
    }
}

// MARK:- Action Methods -
extension PatientDetailViewController {
    
    @IBAction func btnUnknownClicked(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
            sender.backgroundColor = UIColor.init(red: 197.0/255.0, green: 210.0/255.0, blue: 216.0/255.0, alpha: 1.0)
            
            if sender.tag == 5 {
                segmentGender.selectedSegmentIndex = 0
            }
            
        } else {
            sender.isSelected = true
            sender.backgroundColor = UIColor.init(red: 43.0/255.0, green: 143.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            
            if sender.tag == 5 {
                segmentGender.selectedSegmentIndex = UISegmentedControl.noSegment
            }
        }
    }
    
    @IBAction func btnNextClicked(_ sender: UIButton) {
        /*
        let hospital: HospitalViewController = UIStoryboard.storyboard(.hospital).instantiate()
        self.navigate(to: hospital)
        */
        if isEmptyString(self.txtFirstName.text!) && self.btnFirstNameUnknown.isSelected == false {
            self.showAlert(for: "Please enter firstname")
        } else if isEmptyString(self.txtSurname.text!) && self.btnSurnameUnknown.isSelected == false {
            self.showAlert(for: "Please enter surname")
        } else if isEmptyString(self.txtDOB.text!) && self.btnDOBUnknown.isSelected == false {
            self.showAlert(for: "Please select dob")
        } else if isEmptyString(self.txtAddress.text!) && self.btnAddressUnknown.isSelected == false {
            self.showAlert(for: "Please enter address")
        } else if isEmptyString(self.txtNextToKIN.text!) && self.btnNextToKINUnknown.isSelected == false {
            self.showAlert(for: "Please enter next to KIN")
        } else if isEmptyString(self.txtNOKTelephone.text!) && self.btnNOKTelephoneUnknown.isSelected == false {
            self.showAlert(for: "Please enter NOK Telephone")
        } else {
            
            if self.btnFirstNameUnknown.isSelected == true && self.btnSurnameUnknown.isSelected == true {
                patientDetailData.strName = "unknown"
            } else if !isEmptyString(self.txtFirstName.text!) && self.btnSurnameUnknown.isSelected == true {
                patientDetailData.strName = self.txtFirstName.text!
                patientDetailData.strFirstName = self.txtFirstName.text!
            } else if !isEmptyString(self.txtSurname.text!) && self.btnFirstNameUnknown.isSelected == true {
                patientDetailData.strName = self.txtSurname.text!
                patientDetailData.strLastName = self.txtSurname.text!
            } else {
                patientDetailData.strName = "\(self.txtFirstName.text!) \(self.txtSurname.text!)"
                patientDetailData.strFirstName = self.txtFirstName.text!
                patientDetailData.strLastName = self.txtSurname.text!
            }
            
            if self.btnDOBUnknown.isSelected {
                patientDetailData.strAge = "unknown"
            } else {
                patientDetailData.strAge = self.txtDOB.text!
            }
            
            if self.btnAddressUnknown.isSelected {
                patientDetailData.strAddress = "unknown"
            } else {
                patientDetailData.strAddress = self.txtAddress.text!
            }
            
            if self.btnNextToKINUnknown.isSelected {
                patientDetailData.strNok = "unknown"
            } else {
                patientDetailData.strNok = self.txtNextToKIN.text!
            }
            
            if self.btnNOKTelephoneUnknown.isSelected {
                patientDetailData.strNOKContact = "unknown"
            } else {
                patientDetailData.strNOKContact = self.txtNOKTelephone.text!
            }
            
            patientDetailData.strGender = self.btnGenderUnspecified.isSelected ? "unspecified" : (segmentGender.selectedSegmentIndex == 0 ? "male" : "female")
            patientDetailData.strLastSeen = self.btnDateUnknown.isSelected ? "unknown" : self.strLastSeen
            
            PrefsManager.saveData(for: "PatientInfo", and: patientDetailData)
            print(PrefsManager.getSavedData(for: "PatientInfo")!)
            
            let arrValues: [String: String] = ["Name": patientDetailData.strName,
                                               "Age": patientDetailData.strAge,
                                               "Gender": patientDetailData.strGender,
                                               "Address": patientDetailData.strAddress,
                                               "Last Seen": patientDetailData.strLastSeen,
                                               "NOK": patientDetailData.strNok,
                                               "NOK Contact": patientDetailData.strNOKContact]
            var cellValue: [CellValues] = []
            
            arrValues.forEach { arrVal in
                let cell = CellValues()
                cell.title = arrVal.key
                cell.value = arrVal.value
                cellValue.append(cell)
            }
            
            let sectionItem = SectionedItem(title: "Details", values: cellValue)
            sectionedItems.append(sectionItem)
            
            NetworkModule.shared.setPatientDetails(first_name: self.btnFirstNameUnknown.isSelected ? "unknown" : self.txtFirstName.text!, last_name: self.btnSurnameUnknown.isSelected ? "unknown" : self.txtSurname.text!, dob: self.btnDOBUnknown.isSelected ? "" : self.strDOB, address: self.btnAddressUnknown.isSelected ? "unknown" : self.txtAddress.text!, gender: self.btnGenderUnspecified.isSelected ? "u" : (segmentGender.selectedSegmentIndex == 0 ? "m" : "f"), last_well: self.btnDateUnknown.isSelected ? "" : self.strLastSeen, nok: self.btnNextToKINUnknown.isSelected ? "unknown" : self.txtNextToKIN.text!, nok_phone: self.btnNOKTelephoneUnknown.isSelected ? "unknown" : self.txtNOKTelephone.text!, hospital_id: "1", initial_location_lat: "-37.9150", initial_location_long: "145.1300", onSuccess: { apiResponsePatientInfo in
                
                print(apiResponsePatientInfo)
                
                PrefsManager.setCaseID(userId: apiResponsePatientInfo.caseId)
                
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
                        
                        let pastMedicalHistoryVC: PastMedicalHistoryViewController = UIStoryboard.storyboard(.medical).instantiate()
                        self.navigate(to: pastMedicalHistoryVC)
                        
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
}

// MARK:- Private Extension -
private extension PatientDetailViewController {
    
    // Setup
    func setup() {
        
        // Setup Next Button With Gradient Image
        let image1 = self.gradientWithFrametoImage(frame: btnNext.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnNext.backgroundColor = UIColor(patternImage: image1)
        
        // Setup Scan Button With Gradient Image
        let image2 = self.gradientWithFrametoImage(frame: btnScanLicense.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnScanLicense.layer.cornerRadius = 12.0
        self.btnScanLicense.backgroundColor = UIColor(patternImage: image2)
        self.btnScanLicense.isHidden = true
        
        let f = DateFormatter()
        f.dateFormat = "EEEE MMM dd hh:mm a"
        let formattedDate: String = f.string(from: Date())
        let arrayDate = formattedDate.components(separatedBy: " ")
        self.lblDay.text = arrayDate[0].uppercased()
        self.lblDate.text = "\(arrayDate[1]) \((arrayDate[2]))"
        let arrayTime = arrayDate[3].components(separatedBy: ":")
        self.lblHours.text = arrayTime[0]
        self.lblMins.text = arrayTime[1]
        self.lblAMPM.text = arrayDate[4]
        
        f.setLocal()
        f.dateFormat = "yyyy-MM-dd hh:mm:ss"
        self.strLastSeen = f.string(from: Date())
        self.strDOB = self.strLastSeen
    }
    
    // Formats the date chosen with the date picker.
    func formatDateForDisplay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    // Called when the date picker changes.
    @objc func updateDateField(sender: UIDatePicker) {
        
        let f = DateFormatter()
        
        if activeTextField == txtLastSeen {
            
            f.dateFormat = "EEEE MMM dd hh:mm a"
            let formattedDate: String = f.string(from: sender.date)
            
            let arrayDate = formattedDate.components(separatedBy: " ")
            self.lblDay.text = arrayDate[0].uppercased()
            self.lblDate.text = "\(arrayDate[1]) \((arrayDate[2]))"
            let arrayTime = arrayDate[3].components(separatedBy: ":")
            self.lblHours.text = arrayTime[0]
            self.lblMins.text = arrayTime[1]
            self.lblAMPM.text = arrayDate[4]
            
            f.setLocal()
            f.dateFormat = "yyyy-MM-dd hh:mm:ss"
            self.strLastSeen = f.string(from: sender.date)
            
        } else {
            activeTextField?.text = formatDateForDisplay(date: sender.date)
            
            f.dateFormat = "MMM dd, yyyy"
            let formattedDate: String = f.string(from: sender.date)
            self.txtDOB.text = formattedDate
            
            f.setLocal()
            f.dateFormat = "yyyy-MM-dd hh:mm:ss"
            self.strDOB = f.string(from: sender.date)
        }
    }
}

extension PatientDetailViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
        
        // Create a date picker for the date field.
        let picker = UIDatePicker()
        picker.addTarget(self, action: #selector(updateDateField(sender:)), for: .valueChanged)
        textField.inputView = picker
        
        if textField == txtDOB {
            picker.datePickerMode = .date
            picker.set18YearValidation()
        } else if textField == txtLastSeen {
            picker.datePickerMode = .dateAndTime
            textField.textColor = UIColor.clear
        }
        
        // If the date field has focus, display a date picker instead of keyboard.
        // Set the text to the date currently displayed by the picker.
        textField.text = formatDateForDisplay(date: picker.date)
    }
}
