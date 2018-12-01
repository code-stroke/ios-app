//
//  ManagementInfoView.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 25/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import UIKit

protocol ManagementInfoViewDelegate {
    
    func showAlert(withTitle title: String, andMessage message: String, isSuccess: Bool)
}

class ManagementInfoView: UIView {
    
    @IBOutlet var container: UIView!
    
    @IBOutlet weak var lblThrombolysis1: UILabel!
    @IBOutlet weak var lblThrombolysis2: UILabel!
    @IBOutlet weak var lblThrombolysis3: UILabel!
    @IBOutlet weak var lblThrombolysis4: UILabel!
    
    @IBOutlet weak var btnNueHeadYes: UIButton!
    @IBOutlet weak var btnNueHeadNo: UIButton!
    
    @IBOutlet weak var btnUnControlledHTNYes: UIButton!
    @IBOutlet weak var btnUnControlledHTNNo: UIButton!
    
    @IBOutlet weak var btnHistoryOfICHYes: UIButton!
    @IBOutlet weak var btnHistoryOfICHNo: UIButton!
    
    @IBOutlet weak var btnKnownIntracranialYes: UIButton!
    @IBOutlet weak var btnKnownIntracraniaNo: UIButton!
    
    @IBOutlet weak var btnActiveBleedingYes: UIButton!
    @IBOutlet weak var btnActiveBleedingNo: UIButton!
    
    @IBOutlet weak var btnEndocarditisYes: UIButton!
    @IBOutlet weak var btnEndocarditisNo: UIButton!
    
    @IBOutlet weak var btnKnownBleedingDiathesisYes: UIButton!
    @IBOutlet weak var btnKnownBleedingDiathesisNo: UIButton!
    
    @IBOutlet weak var btnAbnormalBloodGlucoseYes: UIButton!
    @IBOutlet weak var btnAbnormalBloodGlucoseNo: UIButton!
    
    @IBOutlet weak var btnRapidlyImprovingYes: UIButton!
    @IBOutlet weak var btnRapidlyImprovingNo: UIButton!
    
    @IBOutlet weak var btnRecentTraumaSurgeryYes: UIButton!
    @IBOutlet weak var btnRecentTraumaSurgeryNo: UIButton!
    
    @IBOutlet weak var btnRecentActiveBleedingYes: UIButton!
    @IBOutlet weak var btnRecentActiveBleedingNo: UIButton!
    
    @IBOutlet weak var btnSeizureAtOnsetYes: UIButton!
    @IBOutlet weak var btnSeizureAtOnsetNo: UIButton!
    
    @IBOutlet weak var btnRecenntArterialPunctureYes: UIButton!
    @IBOutlet weak var btnRecenntArterialPunctureNo: UIButton!
    
    @IBOutlet weak var bntRecentLumbarPunctureYes: UIButton!
    @IBOutlet weak var bntRecentLumbarPunctureNo: UIButton!
    
    @IBOutlet weak var btnPostACSPericarditisYes: UIButton!
    @IBOutlet weak var btnPostACSPericarditisNo: UIButton!
    
    @IBOutlet weak var btnPregnantYes: UIButton!
    @IBOutlet weak var btnPregnantNo: UIButton!
    
    @IBOutlet weak var btnTimeWhenThrombolysisYes: UIButton!
    @IBOutlet weak var btnTimeWhenThrombolysisNNo: UIButton!
    
    @IBOutlet weak var btnECRYes: UIButton!
    @IBOutlet weak var btnECRNo: UIButton!
    
    @IBOutlet weak var btnSurgicalManagementYes: UIButton!
    @IBOutlet weak var btnSurgicalManagementNo: UIButton!
    
    @IBOutlet weak var btnConservativeManagementYes: UIButton!
    @IBOutlet weak var btnConservativeManagementNo: UIButton!
    
    @IBOutlet weak var btnCaseCompleted: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Delegate
    var delegate: ManagementInfoViewDelegate? = nil
    
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
        
        Bundle.main.loadNibNamed(String(describing: ManagementInfoView.self), owner: self, options: nil)
        self.container.frame = self.bounds
        self.addSubview(self.container)
        self.clipsToBounds = true
        
        // Setup Submit Button With Gradient Image
        self.setGradientToButton(for: self.btnSubmit, with: 12.0)
        
        self.getManagementInfo()
    }
}

// MARK:- Action Methods -
extension ManagementInfoView {
    
    @IBAction func btnNueHeadTraumaClickek(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnNueHeadYes, self.btnNueHeadNo], selectedButton: sender)
    }
    
    @IBAction func btnUnControlledHTNClickek(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnUnControlledHTNNo, self.btnUnControlledHTNYes], selectedButton: sender)
    }
    
    @IBAction func btnHistoryOfICHClickek(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnHistoryOfICHNo, self.btnHistoryOfICHYes], selectedButton: sender)
    }
    
    @IBAction func btnKnownIntracranialClickek(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnKnownIntracraniaNo, self.btnKnownIntracranialYes], selectedButton: sender)
    }
    
    @IBAction func btnActiveBleedingClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnActiveBleedingNo, self.btnActiveBleedingYes], selectedButton: sender)
    }
    
    @IBAction func btnEndocarditisClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnEndocarditisYes, self.btnEndocarditisNo], selectedButton: sender)
    }
    
    @IBAction func btnKnownBleedingDiathesisClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnKnownBleedingDiathesisNo, self.btnKnownBleedingDiathesisYes], selectedButton: sender)
    }
    
    @IBAction func btnAbnormalBloodGlucoseClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnAbnormalBloodGlucoseNo, self.btnAbnormalBloodGlucoseYes], selectedButton: sender)
    }
    
    @IBAction func btnRapidlyImprovingClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnRapidlyImprovingNo, self.btnRapidlyImprovingYes], selectedButton: sender)
    }
    
    @IBAction func btnRecentTraumaOrSurgeryClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnRecentTraumaSurgeryNo, self.btnRecentTraumaSurgeryYes], selectedButton: sender)
    }
    
    @IBAction func btnRecentActiveBleedingClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnRecentActiveBleedingNo, self.btnRecentActiveBleedingYes], selectedButton: sender)
    }
    
    @IBAction func btnSeizureAtOnsetClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnSeizureAtOnsetNo, self.btnSeizureAtOnsetYes], selectedButton: sender)
    }
    
    @IBAction func btnRecentArterialPunctureClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnRecenntArterialPunctureNo, self.btnRecenntArterialPunctureYes], selectedButton: sender)
    }
    
    @IBAction func btnRecentLumbarPuntureClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.bntRecentLumbarPunctureYes, self.bntRecentLumbarPunctureNo], selectedButton: sender)
    }
    
    @IBAction func btnPostACSPericarditisClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnPostACSPericarditisNo, self.btnPostACSPericarditisYes], selectedButton: sender)
    }
    
    @IBAction func btnPregnantClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnPregnantNo, self.btnPregnantYes], selectedButton: sender)
    }
    
    @IBAction func btnTimeWhenThrombolysisGivenClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnTimeWhenThrombolysisNNo, self.btnTimeWhenThrombolysisYes], selectedButton: sender)
    }
    
    @IBAction func btnECSClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnECRNo, self.btnECRYes], selectedButton: sender)
    }
    
    @IBAction func btnSurgicalManagementClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnSurgicalManagementNo, self.btnSurgicalManagementYes], selectedButton: sender)
    }
    
    @IBAction func btnConservativeManagementClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnConservativeManagementNo, self.btnConservativeManagementYes], selectedButton: sender)
    }
    
    @IBAction func btnCaseCompletedClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        self.activityIndicator.startAnimating()
        
        NetworkModule.shared.setManagementInfo(thrombolysis: self.btnTimeWhenThrombolysisYes.isSelected ? true : false, new_trauma_haemorrhage: self.btnNueHeadYes.isSelected ? true : false, uncontrolled_htn: self.btnUnControlledHTNYes.isSelected ? true : false, history_ich: self.btnHistoryOfICHYes.isSelected ? true : false, known_intracranial: self.btnKnownIntracranialYes.isSelected ? true : false, active_bleed: self.btnActiveBleedingYes.isSelected ? true : false, endocarditis: self.btnEndocarditisYes.isSelected ? true : false, bleeding_diathesis: self.btnKnownBleedingDiathesisYes.isSelected ? true : false, abnormal_blood_glucose: self.btnAbnormalBloodGlucoseYes.isSelected ? true : false, rapidly_improving: self.btnRapidlyImprovingYes.isSelected ? true : false, recent_trauma_surgery: self.btnRecentTraumaSurgeryYes.isSelected ? true : false, recent_active_bleed: self.btnRecentActiveBleedingYes.isSelected ? true : false, seizure_onset: self.btnSeizureAtOnsetYes.isSelected ? true : false, recent_arterial_puncture: self.btnRecenntArterialPunctureYes.isSelected ? true : false, recent_lumbar_puncture: self.bntRecentLumbarPunctureYes.isSelected ? true : false, post_acs_pericarditis: self.btnPostACSPericarditisYes.isSelected ? true : false, pregnant: self.btnPregnantYes.isSelected ? true : false, thrombolysis_time_given: "", ecr: self.btnECRYes.isSelected ? true : false, surgical_rx: self.btnSurgicalManagementYes.isSelected ? true : false, conservative_rx: self.btnConservativeManagementYes.isSelected ? true : false, onSuccess: { apiResponseManagement in
            
            print(apiResponseManagement)
            
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
extension ManagementInfoView {
    
    func getManagementInfo() {
        
        self.activityIndicator.startAnimating()
        
        NetworkModule.shared.getManagementInfo(onSuccess: { apiResponseManagement in
            print(apiResponseManagement)
            
            self.setWebserviceData(ManagementInfo: apiResponseManagement.managementInfoArray[0])
            
        }, onFailure: { failureReason in
        }, onAction: { responseAction in
        }, onError: { error in
        }, onComplete: { success in
            self.activityIndicator.stopAnimating()
        })
    }
    
    func clearAllAndSelected(buttons: [UIButton], selectedButton: UIButton?) {
        
        buttons.forEach { $0.isSelected = false }
        
        guard let btn = selectedButton else {
            return
        }
        
        btn.isSelected = true
    }
    
    func setWebserviceData(ManagementInfo data: ManagementInfo) {
        
        if data.thrombolysis == true {
            self.lblThrombolysis1.text = "Yes"
            self.lblThrombolysis2.text = "Yes"
            self.lblThrombolysis3.text = "Yes"
            self.lblThrombolysis4.text = "Yes"
        } else if data.thrombolysis == false {
            self.lblThrombolysis1.text = "No"
            self.lblThrombolysis2.text = "No"
            self.lblThrombolysis3.text = "No"
            self.lblThrombolysis4.text = "No"
        } else {
            self.lblThrombolysis1.text = ""
            self.lblThrombolysis2.text = ""
            self.lblThrombolysis3.text = ""
            self.lblThrombolysis4.text = ""
        }
        
        self.clearAllAndSelected(buttons: [self.btnUnControlledHTNYes, self.btnUnControlledHTNNo], selectedButton: data.uncontrolled_htn ? self.btnUnControlledHTNYes : self.btnUnControlledHTNNo)
        
        self.clearAllAndSelected(buttons: [self.btnHistoryOfICHYes, self.btnHistoryOfICHNo], selectedButton: data.history_ich ? self.btnHistoryOfICHYes : self.btnHistoryOfICHNo)
        
        self.clearAllAndSelected(buttons: [self.btnKnownIntracranialYes, self.btnKnownIntracraniaNo], selectedButton: data.known_intracranial ? self.btnKnownIntracranialYes : self.btnKnownIntracraniaNo)
        
        self.clearAllAndSelected(buttons: [self.btnActiveBleedingYes, self.btnActiveBleedingNo], selectedButton: data.active_bleed ? self.btnActiveBleedingYes : self.btnActiveBleedingNo)
        
        self.clearAllAndSelected(buttons: [self.btnEndocarditisYes, self.btnEndocarditisNo], selectedButton: data.endocarditis ? self.btnEndocarditisYes : self.btnEndocarditisNo)
        
        self.clearAllAndSelected(buttons: [self.btnKnownBleedingDiathesisYes, self.btnKnownBleedingDiathesisNo], selectedButton: data.bleeding_diathesis ? self.btnKnownBleedingDiathesisYes : self.btnKnownBleedingDiathesisNo)
        
        self.clearAllAndSelected(buttons: [self.btnAbnormalBloodGlucoseYes, self.btnAbnormalBloodGlucoseNo], selectedButton: data.abnormal_blood_glucose ? self.btnAbnormalBloodGlucoseYes : self.btnAbnormalBloodGlucoseNo)
        
        self.clearAllAndSelected(buttons: [self.btnRapidlyImprovingYes, self.btnRapidlyImprovingNo], selectedButton: data.rapidly_improving ? self.btnRapidlyImprovingYes : self.btnRapidlyImprovingNo)
        
        self.clearAllAndSelected(buttons: [self.btnRecentTraumaSurgeryYes, self.btnRecentTraumaSurgeryNo], selectedButton: data.recent_trauma_surgery ? self.btnRecentTraumaSurgeryYes : self.btnRecentTraumaSurgeryNo)
        
        self.clearAllAndSelected(buttons: [self.btnRecentActiveBleedingYes, self.btnRecentActiveBleedingNo], selectedButton: data.recent_active_bleed ? self.btnRecentActiveBleedingYes : self.btnRecentActiveBleedingNo)
        
        self.clearAllAndSelected(buttons: [self.btnSeizureAtOnsetYes, self.btnSeizureAtOnsetNo], selectedButton: data.seizure_onset ? self.btnSeizureAtOnsetYes : self.btnSeizureAtOnsetNo)
        
        self.clearAllAndSelected(buttons: [self.btnRecenntArterialPunctureYes, self.btnRecenntArterialPunctureNo], selectedButton: data.recent_arterial_puncture ? self.btnRecenntArterialPunctureYes : self.btnRecenntArterialPunctureNo)
        
        self.clearAllAndSelected(buttons: [self.bntRecentLumbarPunctureYes, self.bntRecentLumbarPunctureNo], selectedButton: data.recent_lumbar_puncture ? self.bntRecentLumbarPunctureYes : self.bntRecentLumbarPunctureNo)
        
        self.clearAllAndSelected(buttons: [self.btnPostACSPericarditisYes, self.btnPostACSPericarditisNo], selectedButton: data.post_acs_pericarditis ? self.btnPostACSPericarditisYes : self.btnPostACSPericarditisNo)
        
        self.clearAllAndSelected(buttons: [self.btnPregnantYes, self.btnPregnantNo], selectedButton: data.pregnant ? self.btnPregnantYes : self.btnPregnantNo)
        
        self.clearAllAndSelected(buttons: [self.btnPregnantYes, self.btnPregnantNo], selectedButton: data.pregnant ? self.btnPregnantYes : self.btnPregnantNo)
        
        self.clearAllAndSelected(buttons: [self.btnECRYes, self.btnECRNo], selectedButton: data.ecr ? self.btnECRYes : self.btnECRNo)
        
        self.clearAllAndSelected(buttons: [self.btnECRYes, self.btnECRNo], selectedButton: data.ecr ? self.btnECRYes : self.btnECRNo)
        
        self.clearAllAndSelected(buttons: [self.btnSurgicalManagementYes, self.btnSurgicalManagementNo], selectedButton: data.surgical_rx ? self.btnSurgicalManagementYes : self.btnSurgicalManagementNo)
        
        self.clearAllAndSelected(buttons: [self.btnConservativeManagementYes, self.btnConservativeManagementNo], selectedButton: data.conservative_rx ? self.btnConservativeManagementYes : self.btnConservativeManagementNo)
    }
}
