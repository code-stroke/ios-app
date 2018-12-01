//
//  ClinicalAssessmentInfoView.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 25/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import DropDown

protocol ClinicalAssessmentInfoViewDelegate {
    
    func showAlert(withTitle title: String, andMessage message: String, isSuccess: Bool)
}

// MARK:- Outlets and Declarations -
class ClinicalAssessmentInfoView: UIView {
    
    @IBOutlet var container: UIView!
    
    @IBOutlet weak var btnFacialDropYes: UIButton!
    @IBOutlet weak var btnFacialDropNo: UIButton!
    @IBOutlet weak var btnFacialDropUnknown: UIButton!
    
    @IBOutlet weak var btnArmDriftYes: UIButton!
    @IBOutlet weak var btnArmDriftNo: UIButton!
    @IBOutlet weak var btnArmDriftUnknown: UIButton!
    
    @IBOutlet weak var btnWeakGripYes: UIButton!
    @IBOutlet weak var btnWeakGripNo: UIButton!
    @IBOutlet weak var btnWeakGripUnknown: UIButton!
    
    @IBOutlet weak var btnSpeechDifficultyYes: UIButton!
    @IBOutlet weak var btnSpeechDifficultyNo: UIButton!
    @IBOutlet weak var btnSpeechDifficultyUnknown: UIButton!
    
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtHeartRate: UITextField!
    @IBOutlet weak var txtRespiratoryRate: UITextField!
    @IBOutlet weak var txtOxygenSaturation: UITextField!
    @IBOutlet weak var txtTemperature: UITextField!
    @IBOutlet weak var txtBloodGlucose: UITextField!
    @IBOutlet weak var txtGCS: UITextField!
    
    @IBOutlet weak var btnRegular: UIButton!
    @IBOutlet weak var btnIrregular: UIButton!
    
    @IBOutlet weak var txtHeadAndGazeDeviation: UITextField!
    @IBOutlet weak var txtArmMotorImpairment: UITextField!
    @IBOutlet weak var txtLegMotorImpairment: UITextField!
    @IBOutlet weak var txtFacialPalsy: UITextField!
    
    @IBOutlet weak var btn18GIVYes: UIButton!
    @IBOutlet weak var btn18GIVNo: UIButton!
    
    @IBOutlet weak var segmentHemiparesis: UISegmentedControl!
    
    @IBOutlet weak var txtLevelOfConsciousness: UITextField!
    @IBOutlet weak var txtMonthAndAge: UITextField!
    @IBOutlet weak var txtBlinkEye: UITextField!
    @IBOutlet weak var txtHorizontalGaze: UITextField!
    @IBOutlet weak var txtVisualFields: UITextField!
    @IBOutlet weak var txtNIHSS_Facial_Palsy: UITextField!
    @IBOutlet weak var txtLeftArmDrift: UITextField!
    @IBOutlet weak var txtRightArmDrift: UITextField!
    @IBOutlet weak var txtLeftLegDrift: UITextField!
    @IBOutlet weak var txtRightLegDrift: UITextField!
    @IBOutlet weak var txtLimbAtaxia: UITextField!
    @IBOutlet weak var txtSensation: UITextField!
    @IBOutlet weak var txtAlphasia: UITextField!
    @IBOutlet weak var txtDysarthria: UITextField!
    @IBOutlet weak var txtExtinction: UITextField!
    @IBOutlet weak var txtLevelOfConsciousness_Rankin: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Delegate
    var delegate: ClinicalAssessmentInfoViewDelegate? = nil
    
    private let headAndGazeDropDown                     = DropDown()
    private let armMotorDropDown                        = DropDown()
    private let legMotorDropDown                        = DropDown()
    private let facialPalsyDropDown                     = DropDown()
    
    private let aphasiaDropDown                         = DropDown()
    private let dysarthriaDropDown                      = DropDown()
    private let extinctionDropDown                      = DropDown()
    private let levelOfConsciousness_Rankin_DropDown    = DropDown()
    
    private let rightLegDropDown                        = DropDown()
    private let leftLegDropDown                         = DropDown()
    private let limbAtaxiaDropDown                      = DropDown()
    private let sensationDropDown                       = DropDown()
    
    private let visualFieldsDropDown                    = DropDown()
    private let NIHSSFacialPalsyDropDown                = DropDown()
    private let leftArmDriftDropDown                    = DropDown()
    private let rightArmDriftDropDown                   = DropDown()
    
    private let levelOfConsciousnessDropDown            = DropDown()
    private let monthAndGazeDropDown                    = DropDown()
    private let blinkEyeDropDown                        = DropDown()
    private let horizontalGazeDropDown                  = DropDown()
    
    private let arrArmMotorDropDown = ["Normal-Mild", "Mod", "Severe"]
    private let arrLegMotorDropDown = ["Normal-Mild", "Mod", "Severe"]
    private let arrHeadAndGazeDropDown = ["Absent", "Present"]
    private let arrFacialPalsyDropDown = ["Normal-Mild", "Mod", "Severe"]
    private let arrLevelOfConsciousnessDropDown = ["Alert", "Minor Stimulation", "Repeated Stimulation", "Movement to pain", "Posture or unresponsive"]
    private let arrMonthAndGazeDropDown = ["Both Correct", "1 Correct", "0 Correct"]
    private let arrBlinkEyeDropDown = ["Both Correct", "1 Correct", "0 Correct"]
    private let arrHorizontalGazeDropDown = ["Normal", "Partial palsy", "Forced gaze palsy"]
    private let arrVsualFieldsDropDown = ["No loss", "Partial hemianopia", "Complete hemianopia", "Bilateral hemianopia"]
    private let arrNIHSSFacialPalsyDropDown = ["Normal", "Minor paralysis", "Partial paralysis", "Unilateral/Bilateral complete paralysis"]
    private let arrLeftArmDriftDropDown = ["No drift for 10 seconds", "Mild drift", "Drift/some effort against gravity", "No effort against gravity", "No movement"]
    private let arrRightArmDriftDropDown = ["No drift for 10 seconds", "Mild drift", "Drift/some effort against gravity", "No effort against gravity", "No movement"]
    private let arrLeftLegDropDown = ["No drift for 10 seconds", "Mild drift", "Drift/some effort against gravity", "No effort against gravity", "No movement"]
    private let arrRightLegDropDown = ["No drift for 10 seconds", "Mild drift", "Drift/some effort against gravity", "No effort against gravity", "No movement"]
    private let arrLimbAtaxiaDropDown = ["No ataxia/paralysed/amputation/ unable to understand", "1 limb", "2 limbs"]
    private let arrSensationDropDown = ["Normal", "Mild-moderate loss", "Complete loss/unresponsive"]
    private let arrAphasiaDropDown = ["Normal", "Mild-moderate", "Severe(fragmentary expression, unable to identify)", "Mute/global aphasia/unresponsive"]
    private let arrDysarthriaDropDown = ["Normal/intubated", "Mild-moderate", "Severe/mute"]
    private let arrExtinctionDropDown = ["Normal", "Inattention to 1 modality/bilaterally", "Profound neglet/more than 1 modality"]
    private let arrLevelOfConsciousness_Rankin_DropDown = ["No symptoms", "No disability despite symptoms", "Slite disability but independent with", "Moderate disability but able to walk", "Moderate to severe disability requiring", "Bidridden"]
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.headAndGazeDropDown,
            self.armMotorDropDown,
            self.legMotorDropDown,
            self.facialPalsyDropDown,
            self.aphasiaDropDown,
            self.dysarthriaDropDown,
            self.extinctionDropDown,
            self.levelOfConsciousness_Rankin_DropDown,
            self.rightLegDropDown,
            self.leftLegDropDown,
            self.limbAtaxiaDropDown,
            self.sensationDropDown,
            self.visualFieldsDropDown,
            self.NIHSSFacialPalsyDropDown,
            self.leftArmDriftDropDown,
            self.rightArmDriftDropDown,
            self.levelOfConsciousnessDropDown,
            self.monthAndGazeDropDown,
            self.blinkEyeDropDown,
            self.horizontalGazeDropDown
        ]
    }()
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnLikelyLVO: UIButton!
    
    var selected_FacialPalsy        = 0
    var selected_ArmMotorImp        = 0
    var selected_LegMotorImp        = 0
    var selected_HeadGaze           = 0
    var selected_LevelCons          = 0
    var selected_MonthAge           = 0
    var selected_BlinnkEye          = 0
    var selected_HorizontalGaze     = 0
    var selected_VisualPalsy        = 0
    var selected_FacialPalsy_NIHSS  = 0
    var selected_LeftArmDrift       = 0
    var selected_LeftLegDrift       = 0
    var selected_RightArmDrift      = 0
    var selected_RightLegDrift      = 0
    var selected_LimbAtaxia         = 0
    var selected_Sensation          = 0
    var selected_Aphasia            = 0
    var selected_Dysarthria         = 0
    var selected_Extinction         = 0
    var selected_LevelCons_Rankin   = 0
    
    var isLikelyLVO: Bool           = false
    
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
        
        Bundle.main.loadNibNamed(String(describing: ClinicalAssessmentInfoView.self), owner: self, options: nil)
        self.container.frame = self.bounds
        self.addSubview(self.container)
        self.clipsToBounds = true
        
        setupDropDowns()
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .any }
        
        // Setup Submit and LikelyLVO Button With Gradient Image
        self.setGradientToButton(for: self.btnLikelyLVO, with: 12.0)
        self.setGradientToButton(for: self.btnSubmit, with: 12.0)
        
        self.getClinicalAssessmentInfo()
    }
}

// MARK:- Action Methods -
extension ClinicalAssessmentInfoView {
    
    @IBAction func btnArmDriftOptClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnArmDriftYes, self.btnArmDriftNo, self.btnArmDriftUnknown], selectedButton: sender)
    }
    
    @IBAction func btnFacialDroopOptClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnFacialDropYes, self.btnFacialDropNo, self.btnFacialDropUnknown], selectedButton: sender)
    }
    
    @IBAction func btnWeakGripOptClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnWeakGripNo, self.btnWeakGripYes, self.btnWeakGripUnknown], selectedButton: sender)
    }
    
    @IBAction func btnSpeechDifficultyOptClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnSpeechDifficultyNo, self.btnSpeechDifficultyYes, self.btnSpeechDifficultyUnknown], selectedButton: sender)
    }
    
    @IBAction func btnHeartRythmClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnRegular, self.btnIrregular], selectedButton: sender)
    }
    
    @IBAction func btn18GIVCannulaClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btn18GIVYes, self.btn18GIVNo], selectedButton: sender)
    }
    
    @IBAction func btnLikelyLVOClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        self.activityIndicator.startAnimating()
        
        NetworkModule.shared.setClinicalAssessmentInfo(facial_droop: self.btnFacialDropUnknown.isSelected ? "unknown" : (self.btnFacialDropYes.isSelected ? "yes" : self.btnFacialDropNo.isSelected ? "no" : ""), arm_drift: self.btnArmDriftUnknown.isSelected ? "unknown" : (self.btnArmDriftYes.isSelected ? "yes" : self.btnArmDriftNo.isSelected ? "no" : ""), weak_grip: self.btnWeakGripUnknown.isSelected ? "unknown" : (self.btnWeakGripYes.isSelected ? "yes" : self.btnWeakGripNo.isSelected ? "no" : ""), speech_difficulty: self.btnSpeechDifficultyUnknown.isSelected ? "unknown" : (self.btnSpeechDifficultyYes.isSelected ? "yes" : self.btnSpeechDifficultyNo.isSelected ? "no" : ""), bp_systolic: 0, bp_diastolic: 0, heart_rate: isEmptyString(self.txtHeartRate.text!) ? 0 : Int(self.txtHeartRate.text!)!, heart_rhythm: self.btnRegular.isSelected ? "regular" : self.btnIrregular.isSelected ? "irregular" : "", rr: isEmptyString(self.txtRespiratoryRate.text!) ? 0 : Int(self.txtRespiratoryRate.text!)!, o2sats: isEmptyString(self.txtOxygenSaturation.text!) ? 0 : Int(self.txtOxygenSaturation.text!)!, temp: isEmptyString(self.txtTemperature.text!) ? 0 : Int(self.txtTemperature.text!)!, gcs: isEmptyString(self.txtGCS.text!) ? 0 : Int(self.txtGCS.text!)!, blood_glucose: isEmptyString(self.txtBloodGlucose.text!) ? 0 : Int(self.txtBloodGlucose.text!)!, facial_palsy_race: selected_FacialPalsy, arm_motor_impair: selected_ArmMotorImp, leg_motor_impair: selected_LegMotorImp, head_gaze_deviate: selected_HeadGaze, hemiparesis: (segmentHemiparesis.selectedSegmentIndex == 0) ? "left" : (segmentHemiparesis.selectedSegmentIndex == 1) ? "right" : "", cannula: self.btn18GIVYes.isSelected ? "yes" : self.btn18GIVNo.isSelected ? "no" : "unknown", conscious_level: selected_LevelCons, month_age: selected_MonthAge, blink_squeeze: selected_BlinnkEye, horizontal_gaze: selected_HorizontalGaze, visual_fields: selected_VisualPalsy, facial_palsy_nihss: selected_FacialPalsy_NIHSS, left_arm_drift: selected_LeftArmDrift, right_arm_drift: selected_RightArmDrift, left_leg_drift: selected_LeftLegDrift, right_leg_drift: selected_LeftLegDrift, limb_ataxia: selected_LimbAtaxia, sensation: selected_Sensation, aphasia: selected_Aphasia, dysarthria: selected_Dysarthria, neglect: selected_Extinction, rankin_conscious: selected_LevelCons_Rankin, likely_lvo: self.isLikelyLVO, onSuccess: { apiResponseClinicalAssessmentInfo in
            
        }, onFailure: { failureReason in
            
        }, onAction: { responseAction in
            
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
extension ClinicalAssessmentInfoView {
    
    func getClinicalAssessmentInfo() {
        
        self.activityIndicator.startAnimating()
        
        NetworkModule.shared.getClinicalAssessmentInfo(onSuccess: { apiResponseClinicalAssessmentInfo in
            print(apiResponseClinicalAssessmentInfo)
            
            self.setWebServiceData(ClinicalAssessmentData: apiResponseClinicalAssessmentInfo.clinicalAssessmentInfoArray[0])
            
        }, onFailure: { failureReason in
        }, onAction: { responseAction in
        }, onError: { error in
        }, onComplete: { success in
            self.activityIndicator.stopAnimating()
        })
    }
    
    func setWebServiceData(ClinicalAssessmentData data: ClinicalAssessmentInfo) {
        
        if data.facial_droop == "" || data.facial_droop == nil {
            
            self.clearAllAndSelected(buttons: [self.btnFacialDropYes, self.btnFacialDropNo, self.btnFacialDropUnknown], selectedButton: nil)
            
        } else if data.facial_droop == "yes" {
            
            self.clearAllAndSelected(buttons: [self.btnFacialDropYes, self.btnFacialDropNo, self.btnFacialDropUnknown], selectedButton: self.btnFacialDropYes)
            
        } else if data.facial_droop == "no" {
            
            self.clearAllAndSelected(buttons: [self.btnFacialDropYes, self.btnFacialDropNo, self.btnFacialDropUnknown], selectedButton: self.btnFacialDropNo)
            
        } else {
            
            self.clearAllAndSelected(buttons: [self.btnFacialDropYes, self.btnFacialDropNo, self.btnFacialDropUnknown], selectedButton: self.btnFacialDropUnknown)
        }
        
        if data.arm_drift == ""  || data.arm_drift == nil {
            
            self.clearAllAndSelected(buttons: [self.btnArmDriftYes, self.btnArmDriftNo, self.btnArmDriftUnknown], selectedButton: nil)
            
        } else if data.arm_drift == "yes" {
            
            self.clearAllAndSelected(buttons: [self.btnArmDriftYes, self.btnArmDriftNo, self.btnArmDriftUnknown], selectedButton: self.btnArmDriftYes)
            
        } else if data.arm_drift == "no" {
            
            self.clearAllAndSelected(buttons: [self.btnArmDriftYes, self.btnArmDriftNo, self.btnArmDriftUnknown], selectedButton: self.btnArmDriftNo)
            
        } else {
            
            self.clearAllAndSelected(buttons: [self.btnArmDriftYes, self.btnArmDriftNo, self.btnArmDriftUnknown], selectedButton: self.btnArmDriftUnknown)
        }
        
        if data.weak_grip == "" || data.weak_grip == nil {
            
            self.clearAllAndSelected(buttons: [self.btnWeakGripNo, self.btnWeakGripYes, self.btnWeakGripUnknown], selectedButton: nil)
            
        } else if data.weak_grip == "yes" {
            
            self.clearAllAndSelected(buttons: [self.btnWeakGripNo, self.btnWeakGripYes, self.btnWeakGripUnknown], selectedButton: self.btnWeakGripYes)
            
        } else if data.weak_grip == "no" {
            
            self.clearAllAndSelected(buttons: [self.btnWeakGripNo, self.btnWeakGripYes, self.btnWeakGripUnknown], selectedButton: self.btnWeakGripNo)
            
        } else {
            
            self.clearAllAndSelected(buttons: [self.btnWeakGripNo, self.btnWeakGripYes, self.btnWeakGripUnknown], selectedButton: self.btnWeakGripUnknown)
        }
        
        if data.speech_difficulty == "" || data.speech_difficulty == nil  {
            
            self.clearAllAndSelected(buttons: [self.btnSpeechDifficultyNo, self.btnSpeechDifficultyYes, self.btnSpeechDifficultyUnknown], selectedButton: nil)
            
        } else if data.speech_difficulty == "yes" {
            
            self.clearAllAndSelected(buttons: [self.btnSpeechDifficultyNo, self.btnSpeechDifficultyYes, self.btnSpeechDifficultyUnknown], selectedButton: self.btnSpeechDifficultyYes)
            
        } else if data.speech_difficulty == "no" {
            
            self.clearAllAndSelected(buttons: [self.btnSpeechDifficultyNo, self.btnSpeechDifficultyYes, self.btnSpeechDifficultyUnknown], selectedButton: self.btnSpeechDifficultyNo)
            
        } else {
            
            self.clearAllAndSelected(buttons: [self.btnSpeechDifficultyNo, self.btnSpeechDifficultyYes, self.btnSpeechDifficultyUnknown], selectedButton: self.btnSpeechDifficultyUnknown)
        }
        
        if data.heart_rhythm == "" || data.heart_rhythm == nil  {
            
            self.clearAllAndSelected(buttons: [self.btnRegular, self.btnIrregular], selectedButton: nil)
            
        } else if data.heart_rhythm == "regular" {
            
            self.clearAllAndSelected(buttons: [self.btnRegular, self.btnIrregular], selectedButton: btnRegular)
            
        } else {
            
            self.clearAllAndSelected(buttons: [self.btnRegular, self.btnIrregular], selectedButton: btnIrregular)
        }
        
        if data.cannula == "yes" {
            
            self.clearAllAndSelected(buttons: [self.btn18GIVYes, self.btn18GIVNo], selectedButton: self.btn18GIVYes)
            
        } else if data.cannula == "no" {
            
            self.clearAllAndSelected(buttons: [self.btn18GIVYes, self.btn18GIVNo], selectedButton: self.btn18GIVNo)
            
        } else {
            
            self.clearAllAndSelected(buttons: [self.btn18GIVYes, self.btn18GIVNo], selectedButton: nil)
        }
        
        if data.heart_rate == 0 {
            self.txtHeartRate.text = ""
        } else {
            self.txtHeartRate.text = "\(data.heart_rate)"
        }
        
        if data.rr == 0 {
            self.txtRespiratoryRate.text = ""
        } else {
            self.txtRespiratoryRate.text = "\(data.rr)"
        }
        
        if data.o2sats == 0 {
            self.txtOxygenSaturation.text = ""
        } else {
            self.txtOxygenSaturation.text = "\(data.o2sats)"
        }
        
        if data.temp == 0 {
            self.txtTemperature.text = ""
        } else {
            self.txtTemperature.text = "\(data.temp)"
        }
        
        if data.blood_glucose == 0 {
            self.txtBloodGlucose.text = ""
        } else {
            self.txtBloodGlucose.text = "\(data.blood_glucose)"
        }
        
        if data.gcs == 0 {
            self.txtGCS.text = ""
        } else {
            self.txtGCS.text = "\(data.gcs)"
        }
        
        if data.head_gaze_deviate == 0 {
            self.txtHeadAndGazeDeviation.text = ""
        } else {
            self.txtHeadAndGazeDeviation.text = self.arrHeadAndGazeDropDown[data.head_gaze_deviate]
        }
        
        if data.arm_motor_impair == 0 {
            self.txtArmMotorImpairment.text = ""
        } else {
            self.txtArmMotorImpairment.text = self.arrArmMotorDropDown[data.arm_motor_impair]
        }
        
        if data.leg_motor_impair == 0 {
            self.txtLegMotorImpairment.text = ""
        } else {
            self.txtLegMotorImpairment.text = self.arrLegMotorDropDown[data.leg_motor_impair]
        }
        
        if data.facial_palsy_race == 0 {
            self.txtFacialPalsy.text = ""
        } else {
            self.txtFacialPalsy.text = self.arrFacialPalsyDropDown[data.facial_palsy_race]
        }
        
        if data.conscious_level == 0 {
            self.txtLevelOfConsciousness.text = ""
        } else {
            self.txtLevelOfConsciousness.text = self.arrLevelOfConsciousnessDropDown[data.conscious_level]
        }
        
        if data.month_age == 0 {
            self.txtMonthAndAge.text = ""
        } else {
            self.txtMonthAndAge.text = self.arrMonthAndGazeDropDown[data.month_age]
        }
        
        if data.blink_squeeze == 0 {
            self.txtBlinkEye.text = ""
        } else {
            self.txtBlinkEye.text = self.arrBlinkEyeDropDown[data.blink_squeeze]
        }
        
        if data.horizontal_gaze == 0 {
            self.txtHorizontalGaze.text = ""
        } else {
            self.txtHorizontalGaze.text = self.arrHorizontalGazeDropDown[data.horizontal_gaze]
        }
        
        if data.visual_fields == 0 {
            self.txtVisualFields.text = ""
        } else {
            self.txtVisualFields.text = self.arrVsualFieldsDropDown[data.visual_fields]
        }
        
        if data.facial_palsy_nihss == 0 {
            self.txtNIHSS_Facial_Palsy.text = ""
        } else {
            self.txtNIHSS_Facial_Palsy.text = self.arrNIHSSFacialPalsyDropDown[data.facial_palsy_nihss]
        }
        
        if data.left_arm_drift == 0 {
            self.txtLeftArmDrift.text = ""
        } else {
            self.txtLeftArmDrift.text = self.arrLeftArmDriftDropDown[data.left_arm_drift]
        }
        
        if data.right_arm_drift == 0 {
            self.txtRightArmDrift.text = ""
        } else {
            self.txtRightArmDrift.text = self.arrRightArmDriftDropDown[data.right_arm_drift]
        }
        
        
        if data.left_leg_drift == 0 {
            self.txtLeftLegDrift.text = ""
        } else {
            self.txtLeftLegDrift.text = self.arrLeftLegDropDown[data.left_leg_drift]
        }
        
        if data.right_leg_drift == 0 {
            self.txtRightLegDrift.text = ""
        } else {
            self.txtRightLegDrift.text = self.arrRightLegDropDown[data.right_leg_drift]
        }
        
        if data.limb_ataxia == 0 {
            self.txtLimbAtaxia.text = ""
        } else {
            self.txtLimbAtaxia.text = self.arrLimbAtaxiaDropDown[data.limb_ataxia]
        }
        
        if data.sensation == 0 {
            self.txtSensation.text = ""
        } else {
            self.txtSensation.text = self.arrSensationDropDown[data.sensation]
        }
        
        if data.aphasia == 0 {
            self.txtAlphasia.text = ""
        } else {
            self.txtAlphasia.text = self.arrAphasiaDropDown[data.aphasia]
        }
        
        if data.dysarthria == 0 {
            self.txtDysarthria.text = ""
        } else {
            self.txtDysarthria.text = self.arrDysarthriaDropDown[data.dysarthria]
        }
        
        if data.neglect == 0 {
            self.txtExtinction.text = ""
        } else {
            self.txtExtinction.text = self.arrExtinctionDropDown[data.neglect]
        }
        
        if data.rankin_conscious == 0 {
            self.txtLevelOfConsciousness_Rankin.text = ""
        } else {
            self.txtLevelOfConsciousness_Rankin.text = self.arrLevelOfConsciousness_Rankin_DropDown[data.rankin_conscious]
        }
        
        if data.hemiparesis == "left" {
            self.segmentHemiparesis.selectedSegmentIndex = 0
        } else if data.hemiparesis == "right" {
            self.segmentHemiparesis.selectedSegmentIndex = 1
        } else {
            self.segmentHemiparesis.selectedSegmentIndex = UISegmentedControl.noSegment
        }
        
        if data.likely_lvo == false {
            self.isLikelyLVO = false
        } else {
            self.isLikelyLVO = true
        }
    }
    
    func clearAllAndSelected(buttons: [UIButton], selectedButton: UIButton?) {
        
        buttons.forEach { $0.isSelected = false }
        
        guard let btn = selectedButton else {
            return
        }
        
        btn.isSelected = true
    }
    
    func setupDropDowns() {
        
        setupArmMotorDropDown()
        setupLegMotorDropDown()
        setupHeadGazeDropDown()
        setupFacialPalsyDropDown()
        
        setupLevelOfConsciousnessDropDown()
        setupMonthAndAgeDropDown()
        setupBlinkEyesDropDown()
        setupHorizontalGazeDropDown()
        
        setupVisualFieldsDropDown()
        setupNIHSSFacialPalsyDropDown()
        setupLeftArmDriftDropDown()
        setupRightArmDriftDropDown()
        
        setupLeftLegDriftDropDown()
        setupRightLegDriftDropDown()
        setupLimbAtaxiaDropDown()
        setupSensationDropDown()
        
        setupAphasiaDropDown()
        setupDysarthriaDropDown()
        setupExtinctionDropDown()
        setupLevelOfConsciousness_RankinDropDown()
    }
    
    func setupArmMotorDropDown() {
        
        armMotorDropDown.anchorView = txtArmMotorImpairment
        armMotorDropDown.bottomOffset = CGPoint(x: 0, y: txtArmMotorImpairment.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        armMotorDropDown.dataSource = self.arrArmMotorDropDown
        
        // Action triggered on selection
        armMotorDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_ArmMotorImp = index
            self?.txtArmMotorImpairment.text = item
        }
    }
    
    func setupLegMotorDropDown() {
        
        legMotorDropDown.anchorView = txtLegMotorImpairment
        legMotorDropDown.bottomOffset = CGPoint(x: 0, y: txtLegMotorImpairment.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        legMotorDropDown.dataSource = self.arrLegMotorDropDown
        
        // Action triggered on selection
        legMotorDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_LegMotorImp = index
            self?.txtLegMotorImpairment.text = item
        }
    }
    
    func setupHeadGazeDropDown() {
        
        headAndGazeDropDown.anchorView = txtHeadAndGazeDeviation
        headAndGazeDropDown.bottomOffset = CGPoint(x: 0, y: txtHeadAndGazeDeviation.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        headAndGazeDropDown.dataSource = self.arrHeadAndGazeDropDown
        
        // Action triggered on selection
        headAndGazeDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_HeadGaze = index
            self?.txtHeadAndGazeDeviation.text = item
        }
    }
    
    func setupFacialPalsyDropDown() {
        
        facialPalsyDropDown.anchorView = txtFacialPalsy
        facialPalsyDropDown.bottomOffset = CGPoint(x: 0, y: txtFacialPalsy.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        facialPalsyDropDown.dataSource = self.arrFacialPalsyDropDown
        
        // Action triggered on selection
        facialPalsyDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_FacialPalsy = index
            self?.txtFacialPalsy.text = item
        }
    }
    
    func setupLevelOfConsciousnessDropDown() {
        
        levelOfConsciousnessDropDown.anchorView = txtLevelOfConsciousness
        levelOfConsciousnessDropDown.bottomOffset = CGPoint(x: 0, y: txtLevelOfConsciousness.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        levelOfConsciousnessDropDown.dataSource = self.arrLevelOfConsciousnessDropDown
        
        // Action triggered on selection
        levelOfConsciousnessDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_LevelCons = index
            self?.txtLevelOfConsciousness.text = item
        }
    }
    
    func setupMonthAndAgeDropDown() {
        
        monthAndGazeDropDown.anchorView = txtMonthAndAge
        monthAndGazeDropDown.bottomOffset = CGPoint(x: 0, y: txtMonthAndAge.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        monthAndGazeDropDown.dataSource = self.arrMonthAndGazeDropDown
        
        // Action triggered on selection
        monthAndGazeDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_MonthAge = index
            self?.txtMonthAndAge.text = item
        }
    }
    
    func setupBlinkEyesDropDown() {
        
        blinkEyeDropDown.anchorView = txtBlinkEye
        blinkEyeDropDown.bottomOffset = CGPoint(x: 0, y: txtBlinkEye.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        blinkEyeDropDown.dataSource = self.arrBlinkEyeDropDown
        
        // Action triggered on selection
        blinkEyeDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_BlinnkEye = index
            self?.txtBlinkEye.text = item
        }
    }
    
    func setupHorizontalGazeDropDown() {
        
        horizontalGazeDropDown.anchorView = txtHorizontalGaze
        horizontalGazeDropDown.bottomOffset = CGPoint(x: 0, y: txtHorizontalGaze.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        horizontalGazeDropDown.dataSource = self.arrHorizontalGazeDropDown
        
        // Action triggered on selection
        horizontalGazeDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_HorizontalGaze = index
            self?.txtHorizontalGaze.text = item
        }
    }
    
    func setupVisualFieldsDropDown() {
        
        visualFieldsDropDown.anchorView = txtVisualFields
        visualFieldsDropDown.bottomOffset = CGPoint(x: 0, y: txtVisualFields.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        visualFieldsDropDown.dataSource = self.arrVsualFieldsDropDown
        
        // Action triggered on selection
        visualFieldsDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_VisualPalsy = index
            self?.txtVisualFields.text = item
        }
    }
    
    func setupNIHSSFacialPalsyDropDown() {
        
        NIHSSFacialPalsyDropDown.anchorView = txtNIHSS_Facial_Palsy
        NIHSSFacialPalsyDropDown.bottomOffset = CGPoint(x: 0, y: txtNIHSS_Facial_Palsy.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        NIHSSFacialPalsyDropDown.dataSource = self.arrNIHSSFacialPalsyDropDown
        
        // Action triggered on selection
        NIHSSFacialPalsyDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_FacialPalsy_NIHSS = index
            self?.txtNIHSS_Facial_Palsy.text = item
        }
    }
    
    func setupLeftArmDriftDropDown() {
        
        leftArmDriftDropDown.anchorView = txtLeftArmDrift
        leftArmDriftDropDown.bottomOffset = CGPoint(x: 0, y: txtLeftArmDrift.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        leftArmDriftDropDown.dataSource = self.arrLeftArmDriftDropDown
        
        // Action triggered on selection
        leftArmDriftDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_LeftArmDrift = index
            self?.txtLeftArmDrift.text = item
        }
    }
    
    func setupRightArmDriftDropDown() {
        
        rightArmDriftDropDown.anchorView = txtRightArmDrift
        rightArmDriftDropDown.bottomOffset = CGPoint(x: 0, y: txtRightArmDrift.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        rightArmDriftDropDown.dataSource = self.arrRightArmDriftDropDown
        
        // Action triggered on selection
        rightArmDriftDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_RightArmDrift = index
            self?.txtRightArmDrift.text = item
        }
    }
    
    func setupLeftLegDriftDropDown() {
        
        leftLegDropDown.anchorView = txtLeftLegDrift
        leftLegDropDown.bottomOffset = CGPoint(x: 0, y: txtLeftLegDrift.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        leftLegDropDown.dataSource = self.arrLeftLegDropDown
        
        // Action triggered on selection
        leftLegDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_LeftLegDrift = index
            self?.txtLeftLegDrift.text = item
        }
    }
    
    func setupRightLegDriftDropDown() {
        
        rightLegDropDown.anchorView = txtRightLegDrift
        rightLegDropDown.bottomOffset = CGPoint(x: 0, y: txtRightLegDrift.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        rightLegDropDown.dataSource = self.arrRightLegDropDown
        
        // Action triggered on selection
        rightLegDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_RightLegDrift = index
            self?.txtRightLegDrift.text = item
        }
    }
    
    func setupLimbAtaxiaDropDown() {
        
        limbAtaxiaDropDown.anchorView = txtLimbAtaxia
        limbAtaxiaDropDown.bottomOffset = CGPoint(x: 0, y: txtLimbAtaxia.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        limbAtaxiaDropDown.dataSource = self.arrLimbAtaxiaDropDown
        
        // Action triggered on selection
        limbAtaxiaDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_LimbAtaxia = index
            self?.txtLimbAtaxia.text = item
        }
    }
    
    func setupSensationDropDown() {
        
        sensationDropDown.anchorView = txtSensation
        sensationDropDown.bottomOffset = CGPoint(x: 0, y: txtSensation.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        sensationDropDown.dataSource = self.arrSensationDropDown
        
        // Action triggered on selection
        sensationDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_Sensation = index
            self?.txtSensation.text = item
        }
    }
    
    func setupAphasiaDropDown() {
        
        aphasiaDropDown.anchorView = txtAlphasia
        aphasiaDropDown.bottomOffset = CGPoint(x: 0, y: txtAlphasia.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        aphasiaDropDown.dataSource = self.arrAphasiaDropDown
        
        // Action triggered on selection
        aphasiaDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_Aphasia = index
            self?.txtAlphasia.text = item
        }
    }
    
    func setupDysarthriaDropDown() {
        
        dysarthriaDropDown.anchorView = txtDysarthria
        dysarthriaDropDown.bottomOffset = CGPoint(x: 0, y: txtDysarthria.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        dysarthriaDropDown.dataSource = self.arrDysarthriaDropDown
        
        // Action triggered on selection
        dysarthriaDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_Dysarthria = index
            self?.txtDysarthria.text = item
        }
    }
    
    func setupExtinctionDropDown() {
        
        extinctionDropDown.anchorView = txtExtinction
        extinctionDropDown.bottomOffset = CGPoint(x: 0, y: txtExtinction.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        extinctionDropDown.dataSource = self.arrExtinctionDropDown
        
        // Action triggered on selection
        extinctionDropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_Extinction = index
            self?.txtExtinction.text = item
        }
    }
    
    func setupLevelOfConsciousness_RankinDropDown() {
        
        levelOfConsciousness_Rankin_DropDown.anchorView = txtLevelOfConsciousness_Rankin
        levelOfConsciousness_Rankin_DropDown.bottomOffset = CGPoint(x: 0, y: txtLevelOfConsciousness_Rankin.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        levelOfConsciousness_Rankin_DropDown.dataSource = self.arrLevelOfConsciousness_Rankin_DropDown
        
        // Action triggered on selection
        levelOfConsciousness_Rankin_DropDown.selectionAction = { [weak self] (index, item) in
            self?.selected_LevelCons_Rankin = index
            self?.txtLevelOfConsciousness_Rankin.text = item
        }
    }
}

extension ClinicalAssessmentInfoView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == txtFacialPalsy {
            facialPalsyDropDown.show()
            return false
        } else if textField == txtArmMotorImpairment {
            armMotorDropDown.show()
            return false
        } else if textField == txtLegMotorImpairment {
            legMotorDropDown.show()
            return false
        } else if textField == txtHeadAndGazeDeviation {
            headAndGazeDropDown.show()
            return false
        } else if textField == txtLevelOfConsciousness {
            levelOfConsciousnessDropDown.show()
            return false
        } else if textField == txtMonthAndAge {
            monthAndGazeDropDown.show()
            return false
        } else if textField == txtBlinkEye {
            blinkEyeDropDown.show()
            return false
        } else if textField == txtHorizontalGaze {
            horizontalGazeDropDown.show()
            return false
        } else if textField == txtVisualFields {
            visualFieldsDropDown.show()
            return false
        } else if textField == txtNIHSS_Facial_Palsy {
            NIHSSFacialPalsyDropDown.show()
            return false
        } else if textField == txtLeftArmDrift {
            leftArmDriftDropDown.show()
            return false
        } else if textField == txtRightArmDrift {
            rightArmDriftDropDown.show()
            return false
        } else if textField == txtLeftLegDrift {
            leftLegDropDown.show()
            return false
        } else if textField == txtRightLegDrift {
            rightLegDropDown.show()
            return false
        } else if textField == txtLimbAtaxia {
            limbAtaxiaDropDown.show()
            return false
        } else if textField == txtSensation {
            sensationDropDown.show()
            return false
        }  else if textField == txtAlphasia {
            aphasiaDropDown.show()
            return false
        } else if textField == txtDysarthria {
            dysarthriaDropDown.show()
            return false
        } else if textField == txtExtinction {
            extinctionDropDown.show()
            return false
        } else if textField == txtLevelOfConsciousness_Rankin {
            levelOfConsciousness_Rankin_DropDown.show()
            return false
        }
        
        return true
    }
}
