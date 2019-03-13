//
//  MassViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 07/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit
import EVReflection

let kClinicalAssessmentTwoData = "ClinicalAssessmentTwoData"
let kClinicalAssessmentData = "ClinicalAssessmentData"
let kClinicalAssessmentThreeData = "ClinicalAssessmentThreeData"

class ClinicalAssessmentData: EVObject {
    
    var strFacialDroop: String          = ""
    var strArm_Drift: String            = ""
    var strWeak_Grip: String            = ""
    var strSpeechDifficulty: String     = ""
    
    func save() {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data: NSData = NSKeyedArchiver.archivedData(withRootObject: self) as NSData
        defaults.set(data, forKey: kClinicalAssessmentData)
        defaults.synchronize()
    }
    
    class func savedUser() -> ClinicalAssessmentData? {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data = defaults.object(forKey: kClinicalAssessmentData) as? NSData
        
        if data != nil {
            
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? ClinicalAssessmentData {
                return userinfo
            }
            else {
                return nil
            }
        }
        return nil
    }
    
    class func clearUser() {
        
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: kClinicalAssessmentData)
        defaults.synchronize()
    }
}

// MARK:- Outlets and Properties -
class MassViewController: BaseViewController {
    
    @IBOutlet weak var btnNext: RoundedButton!
    
    @IBOutlet weak var btnFacialDropYes: UIButton!
    @IBOutlet weak var btnFacialDropNo: UIButton!
    @IBOutlet weak var btnFacialDroopUnknown: RoundedButton!
    
    @IBOutlet weak var btnArmDriftYes: UIButton!
    @IBOutlet weak var btnArmDriftNo: UIButton!
    @IBOutlet weak var btnnArmDriftUnknown: RoundedButton!
    
    @IBOutlet weak var btnWeakGripYes: UIButton!
    @IBOutlet weak var btnWeakGripNo: UIButton!
    @IBOutlet weak var btnWeakGripUnknown: RoundedButton!
    
    @IBOutlet weak var btnSpeechDifficultyYes: UIButton!
    @IBOutlet weak var btnSpeechDifficultyNo: UIButton!
    @IBOutlet weak var btnSpeechDifficultyUnknown: RoundedButton!
    
    var clinicalAssessmentData = ClinicalAssessmentData()
}

// MARK:- ViewController LifeCycle -
extension MassViewController {
    
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
extension MassViewController {
    
    @IBAction func btnNextClicked(_ sender: UIButton) {
        ClinicalAssessmentData.clearUser()
        clinicalAssessmentData.strFacialDroop = self.btnFacialDroopUnknown.isSelected ? "unknown" : (self.btnFacialDropYes.isSelected ? "yes" : "no")
        clinicalAssessmentData.strArm_Drift = self.btnnArmDriftUnknown.isSelected ? "unknown" : (self.btnArmDriftYes.isSelected ? "yes" : "no")
        clinicalAssessmentData.strWeak_Grip = self.btnWeakGripUnknown.isSelected ? "unknown" : (self.btnWeakGripYes.isSelected ? "yes" : "no")
        clinicalAssessmentData.strSpeechDifficulty = self.btnSpeechDifficultyUnknown.isSelected ? "unknown" : (self.btnSpeechDifficultyYes.isSelected ? "yes" : "no")
        
        let arrValues: [String: String] = ["Facial droop": clinicalAssessmentData.strFacialDroop,
                                           "Arm drift": clinicalAssessmentData.strArm_Drift,
                                           "Weak grip": clinicalAssessmentData.strWeak_Grip,
                                           "Speech Difficulty": clinicalAssessmentData.strSpeechDifficulty]
        
        clinicalAssessmentData.save()
        var cellValue: [CellValues] = []
        
        arrValues.forEach { arrVal in
            let cell = CellValues()
            cell.title = arrVal.key
            cell.value = arrVal.value
            cellValue.append(cell)
        }
        
        let sectionItem = SectionedItem(title: "Mass", values: cellValue)
        sectionedItems.append(sectionItem)
        
        let vitalsVC: VitalsViewController = UIStoryboard.storyboard(.vitals).instantiate()
        self.navigate(to: vitalsVC)
    }
    
    @IBAction func btnMassItemClicked(_ sender: UIButton) {
        
        var customButton = RoundedButton()
        
        switch sender.tag {
        case 1,2:
            self.clearSelection(for: self.btnFacialDropYes, and: self.btnFacialDropNo)
            customButton = self.btnFacialDroopUnknown
            self.btnFacialDroopUnknown.isSelected = false
            break
        case 3,4:
            self.clearSelection(for: self.btnArmDriftYes, and: self.btnArmDriftNo)
            customButton = self.btnnArmDriftUnknown
            self.btnnArmDriftUnknown.isSelected = false
            break
        case 5,6:
            self.clearSelection(for: self.btnWeakGripYes, and: self.btnWeakGripNo)
            customButton = self.btnWeakGripUnknown
            self.btnWeakGripUnknown.isSelected = false
            break
        case 7,8:
            self.clearSelection(for: self.btnSpeechDifficultyYes, and: self.btnSpeechDifficultyNo)
            customButton = self.btnSpeechDifficultyUnknown
            self.btnSpeechDifficultyUnknown.isSelected = false
            break
        default:
            break
        }
        
        customButton.backgroundColor = UIColor.init(red: 197.0/255.0, green: 210.0/255.0, blue: 216.0/255.0, alpha: 1.0)
        sender.isSelected = true
    }
    
    @IBAction func btnUnknownClicked(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            self.clearSelection(for: self.btnFacialDropYes, and: self.btnFacialDropNo)
            break
        case 2:
            self.clearSelection(for: self.btnArmDriftYes, and: self.btnArmDriftNo)
            break
        case 3:
            self.clearSelection(for: self.btnWeakGripYes, and: self.btnWeakGripNo)
            break
        case 4:
            self.clearSelection(for: self.btnSpeechDifficultyYes, and: self.btnSpeechDifficultyNo)
            break
        default:
            break
        }
        
        if !sender.isSelected {
         
            sender.isSelected = !sender.isSelected
            
            if sender.isSelected {
                sender.backgroundColor = UIColor.init(red: 43.0/255.0, green: 143.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            } else {
                sender.backgroundColor = UIColor.init(red: 197.0/255.0, green: 210.0/255.0, blue: 216.0/255.0, alpha: 1.0)
            }
        }
    }
}

// MARK:- Private Extension -
fileprivate extension MassViewController {
    
    func setup() {
        
        let image1 = self.gradientWithFrametoImage(frame: btnNext.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnNext.backgroundColor = UIColor(patternImage: image1)
    }
    
    func clearSelection(for button1: UIButton, and button2: UIButton) {
        
        button1.isSelected = false
        button2.isSelected = false
    }
}

// MARK:- Public Extension -
extension MassViewController {
    
    
}
