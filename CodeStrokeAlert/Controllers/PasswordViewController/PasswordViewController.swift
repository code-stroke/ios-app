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
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnContinue: UIButton!
}

// MARK:- ViewController LifeCycle -
extension PasswordViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Initialize Navigation
        self.initialise(withNavBarStyle: .standard, leftNavBarButtonType: .back, rightNavBarButtonType: .none, customImage: #imageLiteral(resourceName: "ic_logo.png"))
        
        // Setup Continue Button With Gradient Image
        self.setGradientToButton(for: self.btnContinue, with: 12.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.txtPassword.becomeFirstResponder()
    }
}

// MARK:- Action Methods -
extension PasswordViewController {
    
    @IBAction func btnContinueClicked(_ sender: UIButton) {
        
        self.btnContinue.startLoading()
        var strMessage = ""
        
        if isEmptyString(self.txtPassword.text!) {
            strMessage = "Please enter password"
        } else if self.txtPassword.text!.length < 6 {
            strMessage = "Password must greter then 6 characters"
        } else if isEmptyString(self.txtConfirmPassword.text!) {
            strMessage = "Please enter confirm password"
        } else if self.txtConfirmPassword.text!.length < 6 {
            strMessage = "Confirm password must greter then 6 characters"
        } else if self.txtPassword.text != self.txtConfirmPassword.text! {
            strMessage = "Password and confirm password does not match"
        }
        
        if strMessage == "" {
            
            NetworkModule.shared.setPassword(password: self.txtPassword.text!, onSuccess: { apiResponsePair in
                print(apiResponsePair)
                self.btnContinue.stopLoading()
                
                PrefsManager.setPass(password: self.txtPassword.text!)
                
                let tokenInfo = PrefsManager.getSavedData(for: TOKENINFO) as! TokenInfo
                let enteredCreds = EnteredCreds()
                enteredCreds.username = tokenInfo.username
                enteredCreds.password = self.txtPassword.text!
                PrefsManager.saveData(for: ENTEREDCREDS, and: enteredCreds)
                
                NetworkModule.shared.login(onSuccess: { apiResponseLogin in
                    print(apiResponseLogin)
                    
                    // Handle apiResponseLogin
                    //
                    // Save User
                    UserManager.add(user: apiResponseLogin.userInfo)
                    
                    // Create Alert Controller
                    let alertController = PGAlertViewController(title: "CodeStrokeAlert", message: "Login successfull", style: .success, dismissable: false, actions: [PGAlertAction(title: "OK", style: .normal, handler: {
                        
                        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard.storyboard(.main).instantiateInitialViewController()
                    }) ])
                    
                    // Show alert controller
                    self.present(alertController, animated: true, completion: nil)
                    
                }, onFailure: { failureReason in
                    
                    // Switch failure reason
                    if failureReason == .wrongCredentials {
                        print(failureReason)
                    }
                    
                }, onAction: { responseAction in
                    
                    // Show alert for response action
                    if responseAction == .actionUpdate {
                    }
                    
                }, onError: { error in
                    // Show alert for error
                }, onComplete: { success in
                    
                    
                })
                
            }, onFailure: { failureReason in
                
                // Switch failure reason
                print(failureReason)
                self.btnContinue.stopLoading()
                
            }, onAction: { responseAction in
                
                // Show alert for response action
                if responseAction == .actionUpdate {
                    
                }
                
            }, onError: { error in
                // Show alert for error
                self.btnContinue.stopLoading()
            }, onComplete: { success in
                
            })
        } else {
            
            self.btnContinue.stopLoading()
            
            let alertController = PGAlertViewController(title: "CodeStrokeAlert", message: strMessage, style: .success, dismissable: false, actions: [PGAlertAction(title: "OK", style: .normal, handler: {
                    self.txtPassword.becomeFirstResponder()
            }) ])
            
            // Show alert controller
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK:- Private Extension -
private extension PasswordViewController {
    
    
}

// MARK:- Public Extension -
extension PasswordViewController {
    
    
}
