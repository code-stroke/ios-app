//
//  PasswordViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 14/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit

// MARK:- Outlets and Properties -
class PasswordViewController: BaseViewController {
    
    
}

// MARK:- ViewController LifeCycle -
extension PasswordViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Initialize Navigation
        self.initialise(withNavBarStyle: .standard, leftNavBarButtonType: .back, rightNavBarButtonType: .none, customImage: #imageLiteral(resourceName: "ic_logo.png"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
}

// MARK:- Private Extension -
private extension PasswordViewController {
    
    
}

// MARK:- Public Extension -
extension PasswordViewController {
    
    
}
