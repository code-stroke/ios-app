//
//  MainContainerViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 02/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit

let dashBoardStoryboard = UIStoryboard(name: "Clinician", bundle: nil)

// MARK:- Outlets and Initilization -
class MainContainerViewController: BaseViewController {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewShadow: UIView!
    
    @IBOutlet weak var edInfoView: EDInfoView!
    @IBOutlet weak var patientInfoView: PatientInfoView!
    @IBOutlet weak var clinicalInfoView: ClinicalInfoView!
    @IBOutlet weak var clinicalAssessmentView: ClinicalAssessmentInfoView!
    @IBOutlet weak var radiologyInfoView: RadiologyInfoView!
    @IBOutlet weak var managementInfoView: ManagementInfoView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLastSeen: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblCaseType: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblETA: UILabel!
    
    @IBOutlet weak var btnED: UIButton!
    @IBOutlet weak var btnPatientDetail: UIButton!
    @IBOutlet weak var btnClinicalHistory: UIButton!
    @IBOutlet weak var btnClinicalAssessment: UIButton!
    @IBOutlet weak var btnRadiology: UIButton!
    @IBOutlet weak var btnManagement: UIButton!
    @IBOutlet weak var scrlView: UIScrollView!
    
    var selectedCase: Case? = nil
}

// MARK:- ViewController LifeCycle -
extension MainContainerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edInfoView.delegate = self
        self.patientInfoView.delegate = self
        self.clinicalInfoView.delegate = self
        self.clinicalAssessmentView.delegate = self
        self.radiologyInfoView.delegate = self
        self.managementInfoView.delegate = self
        
        // Do any additional setup after loading the view.
        if let currentCase = self.selectedCase {
            
            self.lblName.text = "\(currentCase.first_name == "unknown" ? "" : currentCase.first_name ?? "") \(currentCase.last_name == "unknown" ? "" : currentCase.last_name ?? "")"
            lblLastSeen.text = currentCase.last_well
            
            if let dob = currentCase.dob {
                let strDOB = self.calcAge(birthday: dob)
                self.lblAge.text = "\(strDOB)"
            } else {
                self.lblAge.text = "-"
            }
            
            self.lblCaseType.text = currentCase.status
            self.lblGender.text = currentCase.gender == "f" ? "Female" : "Male"
            self.lblETA.text = currentCase.eta
        }
        
        // Initialize
        self.initialise(withNavBarStyle: .standard, leftNavBarButtonType: .back, rightNavBarButtonType: .none, customImage: #imageLiteral(resourceName: "ic_logo.png"))
        
        self.clearAllAndSelected(views: [self.edInfoView, self.patientInfoView, self.clinicalInfoView, self.clinicalAssessmentView, self.radiologyInfoView, self.managementInfoView], selectedView: self.edInfoView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:- Action Methods -
extension MainContainerViewController {
    
    @IBAction func btnTypeClicked(_ sender: UIButton) {
        
        self.clearSelection()
        sender.backgroundColor = UIColor.init(red: 43.0/255.0, green: 143.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        self.buttonCenter(scrollView: scrlView, button: sender)

        if sender.tag == 1 {

            self.clearAllAndSelected(views: [self.edInfoView, self.patientInfoView, self.clinicalInfoView, self.clinicalAssessmentView, self.radiologyInfoView, self.managementInfoView], selectedView: self.edInfoView)
            self.edInfoView.getEDInfo()
            
        } else if sender.tag == 2 {
            
            self.clearAllAndSelected(views: [self.edInfoView, self.patientInfoView, self.clinicalInfoView, self.clinicalAssessmentView, self.radiologyInfoView, self.managementInfoView], selectedView: self.patientInfoView)
            self.patientInfoView.getPatientInfo()
            
        } else if sender.tag == 3 {
            
            self.clearAllAndSelected(views: [self.edInfoView, self.patientInfoView, self.clinicalInfoView, self.clinicalAssessmentView, self.radiologyInfoView, self.managementInfoView], selectedView: self.clinicalInfoView)
            self.clinicalInfoView.getClinicalInfo()
            
        } else if sender.tag == 4 {
            
            self.clearAllAndSelected(views: [self.edInfoView, self.patientInfoView, self.clinicalInfoView, self.clinicalAssessmentView, self.radiologyInfoView, self.managementInfoView], selectedView: self.clinicalAssessmentView)
            self.clinicalAssessmentView.getClinicalAssessmentInfo()
            
        } else if sender.tag == 5 {

            self.clearAllAndSelected(views: [self.edInfoView, self.patientInfoView, self.clinicalInfoView, self.clinicalAssessmentView, self.radiologyInfoView, self.managementInfoView], selectedView: self.radiologyInfoView)
            self.radiologyInfoView.getRadiologyInfo()
            
        } else if sender.tag == 6 {

            self.clearAllAndSelected(views: [self.edInfoView, self.patientInfoView, self.clinicalInfoView, self.clinicalAssessmentView, self.radiologyInfoView, self.managementInfoView], selectedView: self.managementInfoView)
            self.managementInfoView.getManagementInfo()
        }
    }
}

// MARK:- Private Methods -
private extension MainContainerViewController {
    
    func clearSelection() {
        
        self.btnED.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.btnPatientDetail.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.btnClinicalHistory.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.btnClinicalAssessment.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.btnRadiology.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.btnManagement.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
    }
    
    func clearAllAndSelected(views: [UIView], selectedView: UIView) {
        
        views.forEach { $0.isHidden = true }
        selectedView.isHidden = false
    }
}

extension MainContainerViewController: EDInfoViewDelegate, PatientInfoViewDelegate, ClinicalInfoViewDelegate, ClinicalAssessmentInfoViewDelegate, RadiologyInfoViewDelegate, ManagementInfoViewDelegate {
    
    func showAlert(withTitle title: String, andMessage message: String, isSuccess: Bool) {
        
        // Create Alert Controller
        let alertController = PGAlertViewController(title: title, message: message, style: isSuccess ? .success : .error, dismissable: true, actions: [PGAlertAction(title: "OK", style: .normal, handler: {
        }) ])
        
        // Show alert controller
        self.present(alertController, animated: true, completion: nil)
    }
}
