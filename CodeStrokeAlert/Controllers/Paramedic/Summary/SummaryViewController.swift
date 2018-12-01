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
}

// MARK:- ViewController LifeCycle -
extension SummaryViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Initialize
        self.initialise(withNavBarStyle: .standard, leftNavBarButtonType: .back, rightNavBarButtonType: .none, customImage: #imageLiteral(resourceName: "ic_logo.png"))
    }
}

// MARK:- Action Methods -
extension SummaryViewController {
    
    
}

// MARK:- Private Extension -
fileprivate extension SummaryViewController {
    
    
}

// MARK:- Public Extension -
extension SummaryViewController {
    
    
}
