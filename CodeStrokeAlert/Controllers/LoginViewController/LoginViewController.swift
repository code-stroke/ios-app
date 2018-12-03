//
//  LoginViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 29/09/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit

// MARK:- Outlets and Properties -
class LoginViewController: BaseViewController {
    
    // Outlets
//    @IBOutlet weak var txtUsername: UITextField!
//    @IBOutlet weak var txtPassword: UITextField!

//    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    // ViewModel
    var viewModel: LoginViewControllerViewModel!
}

// MARK:- ViewController LifeCycle -
extension LoginViewController {
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Initialize the ViewModel
        self.viewModel = LoginViewControllerViewModelImplementation(self)
        
        // Setup Views
        self.setup()
        
        
        //FIXME: Remove Hardcoded
//        self.txtUsername.text = "jay4"
//        self.txtPassword.text = "123456"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Set Navigation Hidden
        self.navigationController?.navigationBar.isHidden = true
        self.btnRegister.stopLoading()
        let tokenInfo = PrefsManager.getSavedData(for: TOKENINFO)
        
        let isFrom = UserDefaults.standard.bool(forKey: "PASSWORD")
        
        if tokenInfo != nil && isFrom {
            self.navigationController?.navigationBar.isHidden = false
            let passwordVC: PasswordViewController = UIStoryboard.storyboard(.password).instantiate()
            self.navigate(to: passwordVC)
            UserDefaults.standard.set(false, forKey: "PASSWORD")
        }
    }
}

// MARK:- Action Methods -
extension LoginViewController {
    
    // Login
    @IBAction func btnTapLogin(sender: UIButton) {
        
        // Animate login button
//        self.btnLogin.startLoading()
        self.viewModel.onTapLoginButton()
    }
    
    // Register
    @IBAction func btnTapRegister(sender: UIButton) {
        
        self.btnRegister.startLoading()
        self.viewModel.onTapLoginWithQRButton()
    }
}

// MARK:- Private Extension -
private extension LoginViewController {
    
    // Setup
    func setup() {
        
        // Setup Login Button With Gradient Image
//        self.setGradientToButton(for: self.btnLogin, with: 12.0)
        
        // Setup Register Button With Gradient Image
        self.setGradientToButton(for: self.btnRegister, with: 12.0)
    }
}

// MARK:- Public Extension -
extension LoginViewController {
    
    
}
