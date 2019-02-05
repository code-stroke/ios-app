//
//  RegisterViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 14/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit

// MARK:- Outlets and Properties -
class RegisterViewController: BaseViewController {
    
    
}

// MARK:- ViewController LifeCycle -
extension RegisterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Initialize Navigation
        self.initialise(withNavBarStyle: .standard, leftNavBarButtonType: .back, rightNavBarButtonType: .none, customImage: #imageLiteral(resourceName: "ic_logo.png"))
        
        let alertController = PGAlertViewController(title: "CodeStrokeAlert", message: "Scan Successfull", style: .success, dismissable: false, actions: [PGAlertAction(title: "OK", style: .normal, handler: {
            
            let password: PasswordViewController = UIStoryboard.storyboard(.password).instantiate()
            self.navigate(to: password)
        }) ])
        
        // Show alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
}

// MARK:- Private Extension -
private extension RegisterViewController {
    
    
}

// MARK:- Public Extension -
extension RegisterViewController {
    
    
}
