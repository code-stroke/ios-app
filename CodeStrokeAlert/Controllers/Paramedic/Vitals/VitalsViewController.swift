//
//  VitalsViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 07/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit
import EVReflection

class ClinicalAssessmentTwoData: EVObject {
    
    var strBlood_Pressure: String               = ""
    var strHeart_Rate: String                   = ""
    var strHeart_Rhythm: String                 = ""
    var strRespiratory_Rate: String             = ""
    var strOxygen_Saturation: String            = ""
    var strTemperature: String                  = ""
    var strBlood_Glucose: String                = ""
    var strGCS: String                          = ""
}

// MARK:- Outlets and Properties -
class VitalsViewController: BaseViewController {
    
    @IBOutlet weak var leadingGCS: NSLayoutConstraint!
    @IBOutlet weak var btnNext: RoundedButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var btnVerbal: UIButton!
    @IBOutlet weak var btnMotor: UIButton!
    
    @IBOutlet weak var txtBloodPressure: UITextField!
    @IBOutlet weak var txtHeartRate: UITextField!
    @IBOutlet weak var txtRespiratoryRate: UITextField!
    @IBOutlet weak var txtOxygenSaturation: UITextField!
    @IBOutlet weak var txtTemperature: UITextField!
    @IBOutlet weak var txtBloodGlucose: UITextField!
    
    @IBOutlet weak var btnRegular: UIButton!
    @IBOutlet weak var btnIrregular: UIButton!
    
    @IBOutlet weak var btnEyeOption1: UIButton!
    @IBOutlet weak var btnEyeOption2: UIButton!
    @IBOutlet weak var btnEyeOption3: UIButton!
    @IBOutlet weak var btnEyeOption4: UIButton!
    
    @IBOutlet weak var btnVerbalOption1: UIButton!
    @IBOutlet weak var btnVerbalOption2: UIButton!
    @IBOutlet weak var btnVerbalOption3: UIButton!
    @IBOutlet weak var btnVerbalOption4: UIButton!
    @IBOutlet weak var btnVerbalOption5: UIButton!
    
    @IBOutlet weak var btnMoterOption1: UIButton!
    @IBOutlet weak var btnMoterOption2: UIButton!
    @IBOutlet weak var btnMoterOption3: UIButton!
    @IBOutlet weak var btnMoterOption4: UIButton!
    @IBOutlet weak var btnMoterOption5: UIButton!
    @IBOutlet weak var btnMoterOption6: UIButton!
    
    var clinicalAssessmentTwoData = ClinicalAssessmentTwoData()
}

// MARK:- ViewController LifeCycle -
extension VitalsViewController {
    
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
extension VitalsViewController {
    
    @IBAction func btnHeartRythmClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnRegular, self.btnIrregular], selectedButton: sender)
    }
    
    @IBAction func btnGCSClicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.22) {
            
            self.clearAllAndSelected(buttons: [self.btnEye, self.btnVerbal, self.btnMotor], selectedButton: sender)
            self.leadingGCS.constant = sender.frame.origin.x
            let xAxis = sender.tag - 1
            self.scrollView.setContentOffset(CGPoint(x:CGFloat(xAxis) * (self.scrollView.frame.size.width) , y: 0), animated: true)
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func btnEyeClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnEyeOption1, self.btnEyeOption2, self.btnEyeOption3, self.btnEyeOption4], selectedButton: sender)
    }
    
    @IBAction func btnVerbalClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnVerbalOption1, self.btnVerbalOption2, self.btnVerbalOption3, self.btnVerbalOption4, self.btnVerbalOption5], selectedButton: sender)
    }
    
    @IBAction func btnMotorClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnMoterOption1, self.btnMoterOption2, self.btnMoterOption3, self.btnMoterOption4, self.btnMoterOption5, self.btnMoterOption6], selectedButton: sender)
    }
    
    @IBAction func btnNextClicked(_ sender: UIButton) {
        
        clinicalAssessmentTwoData.strBlood_Pressure = isEmptyString(self.txtBloodPressure.text!) ? "NULL" : self.txtBloodPressure.text!
        clinicalAssessmentTwoData.strHeart_Rate = isEmptyString(self.txtHeartRate.text!) ? "NULL" : self.txtHeartRate.text!
        clinicalAssessmentTwoData.strHeart_Rhythm = self.btnRegular.isSelected ? "regular" : "irregular"
        clinicalAssessmentTwoData.strRespiratory_Rate = isEmptyString(self.txtRespiratoryRate.text!) ? "NULL" : self.txtRespiratoryRate.text!
        clinicalAssessmentTwoData.strOxygen_Saturation = isEmptyString(self.txtOxygenSaturation.text!) ? "NULL" : self.txtOxygenSaturation.text!
        clinicalAssessmentTwoData.strTemperature = isEmptyString(self.txtTemperature.text!) ? "NULL" : self.txtTemperature.text!
        clinicalAssessmentTwoData.strBlood_Glucose = isEmptyString(self.txtBloodGlucose.text!) ? "NULL" : self.txtBloodGlucose.text!
        
        var gscSelected = 0
        
        if self.btnEyeOption1.isSelected {
            gscSelected += 1
        } else if self.btnEyeOption1.isSelected {
            gscSelected += 2
        } else if self.btnEyeOption3.isSelected {
            gscSelected += 3
        } else if self.btnEyeOption4.isSelected {
            gscSelected += 4
        }
        
        if self.btnVerbalOption1.isSelected {
            gscSelected += 1
        } else if self.btnVerbalOption2.isSelected {
            gscSelected += 2
        } else if self.btnVerbalOption3.isSelected {
            gscSelected += 3
        } else if self.btnVerbalOption4.isSelected {
            gscSelected += 4
        } else if self.btnVerbalOption5.isSelected {
            gscSelected += 5
        }
        
        if self.btnMoterOption1.isSelected {
            gscSelected += 1
        } else if self.btnMoterOption2.isSelected {
            gscSelected += 2
        } else if self.btnMoterOption3.isSelected {
            gscSelected += 3
        } else if self.btnMoterOption4.isSelected {
            gscSelected += 4
        } else if self.btnMoterOption5.isSelected {
            gscSelected += 5
        } else if self.btnMoterOption6.isSelected {
            gscSelected += 6
        }
        
        clinicalAssessmentTwoData.strGCS = String(gscSelected)
        
        let arrValues: [String: String] = ["Blood pressure": clinicalAssessmentTwoData.strBlood_Pressure,
                                           "Heart Rate": clinicalAssessmentTwoData.strHeart_Rate,
                                           "Heart Rhythm": clinicalAssessmentTwoData.strHeart_Rhythm,
                                           "Respiratory Rate": clinicalAssessmentTwoData.strRespiratory_Rate,
                                           "Oxygen Saturation": clinicalAssessmentTwoData.strOxygen_Saturation,
                                           "Temperature": clinicalAssessmentTwoData.strTemperature,
                                           "Blood Glucose": clinicalAssessmentTwoData.strBlood_Glucose,
                                           "GCS": clinicalAssessmentTwoData.strGCS]
        
        var cellValue: [CellValues] = []
        
        arrValues.forEach { arrVal in
            let cell = CellValues()
            cell.title = arrVal.key
            cell.value = arrVal.value
            cellValue.append(cell)
        }
        
        let sectionItem = SectionedItem(title: "Vitals", values: cellValue)
        sectionedItems.append(sectionItem)
        
        let raceVC: RaceViewController = UIStoryboard.storyboard(.race).instantiate()
        self.navigate(to: raceVC)
    }
}

// MARK:- Private Extension -
fileprivate extension VitalsViewController {
    
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
extension VitalsViewController {
    
    
}
