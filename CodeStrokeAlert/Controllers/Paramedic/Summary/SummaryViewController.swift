//
//  SummaryViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 07/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit

// MARK:- Outlets and Properties -
class SummaryViewController: BaseViewController {
    
    @IBOutlet weak var summaryTableView: SummaryTableView!
    @IBOutlet weak var btnDropOff: UIButton!
}

// MARK:- ViewController LifeCycle -
extension SummaryViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Initialize
        self.initialise(withNavBarStyle: .standard, leftNavBarButtonType: .back, rightNavBarButtonType: .none, customImage: #imageLiteral(resourceName: "ic_logo.png"))
        
        let image1 = self.gradientWithFrametoImage(frame: btnDropOff.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnDropOff.backgroundColor = UIColor(patternImage: image1)
    }
}

// MARK:- Action Methods -
extension SummaryViewController {
    
    @IBAction func btnDropOffClicked(_ sender: UIButton) {
        
        NetworkModule.shared.dropOff(status: "active", onSuccess: { apiResponseBase in
            print(apiResponseBase)
        }, onFailure: { failureReason in
            
        }, onAction: { responseAction in
            
        }, onError: { error in
            // Show alert for error
        }, onComplete: { success in
            
            // Show Alert
            if success {
                // Create Alert Controller
                let alertController = PGAlertViewController(title: "CodeStrokeAlert", message: "Submitted successfully", style: .success, dismissable: false, actions: [PGAlertAction(title: "OK", style: .normal, handler: {
                    
                    UIApplication.shared.keyWindow?.rootViewController = UIStoryboard.storyboard(.main).instantiateInitialViewController()
                    
                }) ])
                
                // Show alert controller
                self.present(alertController, animated: true, completion: nil)
            } else {
                
                // Create Alert Controller
                let alertController = PGAlertViewController(title: "CodeStrokeAlert", message: "Error while submitting data", style: .error, dismissable: true, actions: [PGAlertAction(title: "OK", style: .normal, handler: {
                    
                }) ])
                
                // Show alert controller
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
}

// MARK:- Private Extension -
fileprivate extension SummaryViewController {
    
    
}

// MARK:- Public Extension -
extension SummaryViewController {
    
    
}
