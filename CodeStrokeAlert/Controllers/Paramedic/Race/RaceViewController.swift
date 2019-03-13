//
//  RaceViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 07/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit
import EVReflection

class ClinicalAssessmentThreeData: EVObject {
    
    var strFacial_Palsy_Race: String            = ""
    var strArm_Motor_Impair: String             = ""
    var strLeg_Motor_Impair: String             = ""
    var strHead_Gaze_Deviate: String            = ""
    
    func save() {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data: NSData = NSKeyedArchiver.archivedData(withRootObject: self) as NSData
        defaults.set(data, forKey: kClinicalAssessmentThreeData)
        defaults.synchronize()
    }
    
    class func savedUser() -> ClinicalAssessmentThreeData? {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data = defaults.object(forKey: kClinicalAssessmentThreeData) as? NSData
        
        if data != nil {
            
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? ClinicalAssessmentThreeData {
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
        defaults.removeObject(forKey: kClinicalAssessmentThreeData)
        defaults.synchronize()
    }
}

// MARK:- Outlets and Properties -
class RaceViewController: BaseViewController {
    
    @IBOutlet weak var btnFacialPalsyOption1: UIButton!
    @IBOutlet weak var btnFacialPalsyOption2: UIButton!
    @IBOutlet weak var btnFacialPalsyOption3: UIButton!
    
    @IBOutlet weak var btnArmMoterOption1: UIButton!
    @IBOutlet weak var btnArmMoterOption2: UIButton!
    @IBOutlet weak var btnArmMoterOption3: UIButton!
    
    @IBOutlet weak var btnLegMoterOption1: UIButton!
    @IBOutlet weak var btnLegMoterOption2: UIButton!
    @IBOutlet weak var btnLegMoterOption3: UIButton!
    
    @IBOutlet weak var btnHeadGazeOption1: UIButton!
    @IBOutlet weak var btnHeadGazeOption2: UIButton!
    
    @IBOutlet weak var btnNext: RoundedButton!
    
    var clinicalAssessmentThreeData = ClinicalAssessmentThreeData()
}

// MARK:- ViewController LifeCycle -
extension RaceViewController {
    
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
extension RaceViewController {
    
    @IBAction func btnFacialPalsyOptionsClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnFacialPalsyOption1, self.btnFacialPalsyOption2, self.btnFacialPalsyOption3], selectedButton: sender)
    }
    
    @IBAction func btnArmMoterOptionsClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnArmMoterOption1, self.btnArmMoterOption2, self.btnArmMoterOption3], selectedButton: sender)
    }
    
    @IBAction func btnLegMoterOptionsClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnLegMoterOption1, self.btnLegMoterOption2, self.btnLegMoterOption3], selectedButton: sender)
    }
    
    @IBAction func btnHeadGazeOptionsClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnHeadGazeOption1, self.btnHeadGazeOption2], selectedButton: sender)
    }
    
    @IBAction func btnNextClicked(_ sender: UIButton) {
        
        var facial_palsy_race = 0
        
        if self.btnFacialPalsyOption1.isSelected {
            facial_palsy_race += 0
        } else if self.btnFacialPalsyOption2.isSelected {
            facial_palsy_race += 1
        } else if self.btnFacialPalsyOption3.isSelected {
            facial_palsy_race += 2
        }
        
        var arm_motor_impair = 0
        
        if self.btnArmMoterOption1.isSelected {
            arm_motor_impair += 0
        } else if self.btnArmMoterOption2.isSelected {
            arm_motor_impair += 1
        } else if self.btnArmMoterOption3.isSelected {
            arm_motor_impair += 2
        }
        
        var leg_motor_impair = 0
        
        if self.btnLegMoterOption1.isSelected {
            leg_motor_impair += 0
        } else if self.btnLegMoterOption2.isSelected {
            leg_motor_impair += 1
        } else if self.btnLegMoterOption3.isSelected {
            leg_motor_impair += 2
        }
        
        var head_gaze_deviate = 0
        
        if self.btnHeadGazeOption1.isSelected {
            head_gaze_deviate += 0
        } else if self.btnHeadGazeOption2.isSelected {
            head_gaze_deviate += 1
        }
        
        let strRace = arm_motor_impair + leg_motor_impair + facial_palsy_race + head_gaze_deviate
        ClinicalAssessmentThreeData.clearUser()
        clinicalAssessmentThreeData.strFacial_Palsy_Race = String(facial_palsy_race)
        clinicalAssessmentThreeData.strArm_Motor_Impair = String(arm_motor_impair)
        clinicalAssessmentThreeData.strLeg_Motor_Impair = String(leg_motor_impair)
        clinicalAssessmentThreeData.strHead_Gaze_Deviate = String(head_gaze_deviate)
        clinicalAssessmentThreeData.save()
        
        let arrValues: [String: String] = ["Race": "\(strRace)"]
        
        var cellValue: [CellValues] = []
        
        arrValues.forEach { arrVal in
            let cell = CellValues()
            cell.title = arrVal.key
            cell.value = arrVal.value
            cellValue.append(cell)
        }
        
        let sectionItem = SectionedItem(title: "Race", values: cellValue)
        sectionedItems.append(sectionItem)
        
        let cannulaVC: CannulaViewController = UIStoryboard.storyboard(.cannula).instantiate()
        self.navigate(to: cannulaVC)
    }
}

// MARK:- Private Extension -
fileprivate extension RaceViewController {
    
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
extension RaceViewController {
    
    
}
