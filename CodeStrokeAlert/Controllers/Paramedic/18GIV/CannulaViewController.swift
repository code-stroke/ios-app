//
//  CannulaViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 07/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit
import EVReflection

class Cannula: EVObject {
    
    var cannula: String            = ""
}

// MARK:- Outlets and Properties -
class CannulaViewController: BaseViewController {
    
    @IBOutlet weak var btn18GIVYes: UIButton!
    @IBOutlet weak var btn18GIVNo: UIButton!
    @IBOutlet weak var btn18GIVUnknown: RoundedButton!
    
    @IBOutlet weak var btnNext: RoundedButton!
    
    var cannulaData = Cannula()
}

// MARK:- ViewController LifeCycle -
extension CannulaViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Initialize
        self.initialise(withNavBarStyle: .standard, leftNavBarButtonType: .back, rightNavBarButtonType: .none, customImage: #imageLiteral(resourceName: "ic_logo.png"))
        
        // Setup
        self.setup()
    }
}

// MARK:- Action Methods -
extension CannulaViewController {
    
    @IBAction func btn18GIVClicked(_ sender: UIButton) {
        
        self.btn18GIVUnknown.isSelected = false
        self.btn18GIVUnknown.backgroundColor = UIColor.init(red: 197.0/255.0, green: 210.0/255.0, blue: 216.0/255.0, alpha: 1.0)
        self.clearAllAndSelected(buttons: [self.btn18GIVYes, self.btn18GIVNo], selectedButton: sender)
    }
    
    @IBAction func btnUnknownClicked(_ sender: UIButton) {
        
        self.btn18GIVYes.isSelected = false
        self.btn18GIVNo.isSelected = false
        
        if !sender.isSelected {
            
            sender.isSelected = !sender.isSelected
            
            if sender.isSelected {
                sender.backgroundColor = UIColor.init(red: 43.0/255.0, green: 143.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            } else {
                sender.backgroundColor = UIColor.init(red: 197.0/255.0, green: 210.0/255.0, blue: 216.0/255.0, alpha: 1.0)
            }
        }
    }
    
    @IBAction func btnNextClicked(_ sender: UIButton) {

        cannulaData.cannula = self.btn18GIVYes.isSelected ? "yes" : "no"
        let arrValues: [String: String] = ["Cannuala": "\(cannulaData.cannula)"]
        
        var cellValue: [CellValues] = []
        
        arrValues.forEach { arrVal in
            let cell = CellValues()
            cell.title = arrVal.key
            cell.value = arrVal.value
            cellValue.append(cell)
        }
        
        let sectionItem = SectionedItem(title: "18G IV", values: cellValue)
        sectionedItems.append(sectionItem)
        
        NetworkModule.shared.setClinicalAssessment(facial_droop: ClinicalAssessmentData.savedUser()!.strFacialDroop,
                                                   arm_drift: ClinicalAssessmentData.savedUser()!.strArm_Drift,
                                                   weak_grip: ClinicalAssessmentData.savedUser()!.strWeak_Grip,
                                                   speech_difficulty: ClinicalAssessmentData.savedUser()!.strSpeechDifficulty,
                                                   bp_systolic: ClinicalAssessmentTwoData.savedUser()!.strBlood_Pressure,
                                                   heart_rate: ClinicalAssessmentTwoData.savedUser()!.strHeart_Rate,
                                                   heart_rhythm: ClinicalAssessmentTwoData.savedUser()!.strHeart_Rhythm,
                                                   rr: ClinicalAssessmentTwoData.savedUser()!.strRespiratory_Rate,
                                                   o2sats: ClinicalAssessmentTwoData.savedUser()!.strOxygen_Saturation,
                                                   temp: ClinicalAssessmentTwoData.savedUser()!.strTemperature,
                                                   gcs: ClinicalAssessmentTwoData.savedUser()!.strGCS,
                                                   blood_glucose: ClinicalAssessmentTwoData.savedUser()!.strBlood_Glucose,
                                                   facial_palsy_race: ClinicalAssessmentThreeData.savedUser()!.strFacial_Palsy_Race,
                                                   arm_motor_impair: ClinicalAssessmentThreeData.savedUser()!.strArm_Motor_Impair,
                                                   leg_motor_impair: ClinicalAssessmentThreeData.savedUser()!.strLeg_Motor_Impair,
                                                   head_gaze_deviate: ClinicalAssessmentThreeData.savedUser()!.strHead_Gaze_Deviate,
                                                   cannula: cannulaData.cannula, onSuccess: { apiResponseClinicalAssessmentInfo in
            
        }, onFailure: { failureReason in
            
        }, onAction: { responseAction in
            
        }, onError: { error in
            // Show alert for error
        }, onComplete: { success in
            
            // Show Alert
            if success {
                // Create Alert Controller
                let alertController = PGAlertViewController(title: "CodeStrokeAlert", message: "Submitted successfully", style: .success, dismissable: false, actions: [PGAlertAction(title: "OK", style: .normal, handler: {
                    
                    let summaryVC: SummaryViewController = UIStoryboard.storyboard(.summary).instantiate()
                    self.navigate(to: summaryVC)
                    
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

// MARK:- Private Extension -
fileprivate extension CannulaViewController {
    
    func setup() {
        
        let image1 = self.gradientWithFrametoImage(frame: btnNext.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnNext.backgroundColor = UIColor(patternImage: image1)
    }
    
    func clearAllAndSelected(buttons: [UIButton], selectedButton: UIButton) {
        
        buttons.forEach { $0.isSelected = false }
        selectedButton.isSelected = true
    }
}

// MARK:- Public Extension -
extension CannulaViewController {
    
    
}
