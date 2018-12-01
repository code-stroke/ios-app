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

        cannulaData.cannula = self.btn18GIVYes.isSelected ? "Yes" : "No"
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
        
        let summaryVC: SummaryViewController = UIStoryboard.storyboard(.summary).instantiate()
        self.navigate(to: summaryVC)
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
