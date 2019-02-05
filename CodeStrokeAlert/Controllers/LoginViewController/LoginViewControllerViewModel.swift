//
//  LoginViewControllerViewModel.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 29/09/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import UIKit

// MARK:- Model for required methods -
protocol LoginViewControllerViewModel {
    
    // Login
    func onTapLoginButton()
}

// MARK:- Extension of Model for optional methods -
extension LoginViewControllerViewModel {
    
    
}

// MARK:- ModelImplementation -
class LoginViewControllerViewModelImplementation: LoginViewControllerViewModel {
    
    // View Object
    let view: LoginViewController!
    
    // Initilize
    init(_ view: LoginViewController) {
        self.view = view
    }
    
    // Login
    func onTapLoginButton() {
        
        var message = ""
        
        guard let username = self.view.txtUsername.text,
            let password = self.view.txtPassword.text,
            username.length > 0, password.length > 0 else {
                
                if self.view.txtUsername.text == "" {
                    message = "Please enter username"
                } else if self.view.txtPassword.text == "" {
                    message = "Please enter password"
                }
                
                // Create controller
                let alertController = PGAlertViewController(title: "CodeStrokeAlert", message: message, style: .error, dismissable: true, actions: [PGAlertAction(title: "OK", handler: nil)])
                
                // Show alert controller
                self.view.present(alertController, animated: true, completion: nil)
                
            return
        }
        
        NetworkModule.shared.login(username: username, password: password, onSuccess: { ApiResponseLogin in
            print(ApiResponseLogin)
            
            // Create Alert Controller
            let alertController = PGAlertViewController(title: "CodeStrokeAlert", message: "Login successfull", style: .success, dismissable: false, actions: [PGAlertAction(title: "OK", style: .normal, handler: {
                
                UIApplication.shared.keyWindow?.rootViewController = UIStoryboard.storyboard(.main).instantiateInitialViewController()
            }) ])
            
            // Show alert controller
            self.view.present(alertController, animated: true, completion: nil)
            
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
            
            // Enable login button
            self.view.btnLogin.stopLoading()
        })
    }
}
