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
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    @IBOutlet weak var btnLogin: UIButton!
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Set Navigation Hidden
        self.navigationController?.navigationBar.isHidden = true
    }
}

// MARK:- Action Methods -
extension LoginViewController {
    
    // Login
    @IBAction func btnTapLogin(sender: UIButton) {
        
        // Animate login button
        self.btnLogin.startLoading()
        self.viewModel.onTapLoginButton()
    }
    
    // Register
    @IBAction func btnTapRegister(sender: UIButton) {
        
        // Set Navigation Hidden
        self.navigationController?.navigationBar.isHidden = false
        
        let register: RegisterViewController = UIStoryboard.storyboard(.register).instantiate()
        self.navigate(to: register)
    }
}

// MARK:- Private Extension -
private extension LoginViewController {
    
    // Setup
    func setup() {
        
        // Setup Login Button With Gradient Image
        self.setGradientToButton(for: self.btnLogin, with: 12.0)
        
        // Setup Register Button With Gradient Image
        self.setGradientToButton(for: self.btnRegister, with: 12.0)
    }
    
    // Set Gradient
    func setGradientToButton(for button: UIButton, with cornerRadius: CGFloat) {
        
        let image = self.gradientWithFrametoImage(frame: button.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        button.layer.cornerRadius = cornerRadius
        button.backgroundColor = UIColor(patternImage: image)
    }
}

// MARK:- Public Extension -
extension LoginViewController {
    
    
}
