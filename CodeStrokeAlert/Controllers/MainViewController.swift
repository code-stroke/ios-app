//
//  MainViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 29/09/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit

// MARK:- Outlets and Properties -
class MainViewController: UIViewController {
    
    
}

// MARK:- ViewController LifeCycle -
extension MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Launch PopGuide (after N seconds to let user see the splash screen)
        Utils.execute(after: 0, closure: {
            self.lunchApp()
        })
    }
}

// MARK:- Private Extension -
private extension MainViewController {
    
    func lunchApp() {

        if UserManager.activeUser != nil {
            self.showClinicianFlow()
        } else {
            self.showLoginScreen()
        }
    }
    
    func showLoginScreen() {
        
        let loginViewController: LoginNavigationController = UIStoryboard.storyboard(.login).instantiate()
        self.show(loginViewController, sender: nil)
    }
    
    func showParamedicFlow() {
        
        let patientDetailViewController: ParamedicNavigationController = UIStoryboard.storyboard(.patientdetail).instantiate()
        self.show(patientDetailViewController, sender: nil)
    }
    
    func showClinicianFlow() {
        
        let clinicianNavigationController: ClinicianNavigationController = UIStoryboard.storyboard(.patientlist).instantiate()
        self.show(clinicianNavigationController, sender: nil)
    }
}

// MARK:- Public Extension -
extension MainViewController {
    
    
}
