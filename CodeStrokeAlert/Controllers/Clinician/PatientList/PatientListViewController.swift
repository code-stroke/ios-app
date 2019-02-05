//
//  PatientListViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 09/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit

// MARK:- Outlets and Properties -
class PatientListViewController: BaseViewController {
    
    @IBOutlet weak var tblPatientList: UITableView!
    @IBOutlet weak var btnIncoming: UIButton!
    @IBOutlet weak var btnActive: UIButton!
    @IBOutlet weak var btnCompleted: UIButton!
    @IBOutlet weak var leading_Slider: NSLayoutConstraint!
    
    // SearchBar
    fileprivate var searchBar:                  UITextField!
    fileprivate var isInSearchMode:             Bool            = false
    fileprivate let animation_duration:         TimeInterval    = 0.35
}

// MARK:- ViewController LifeCycle -
extension PatientListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Initialize
        self.initialise(withNavBarStyle: .standard, leftNavBarButtonType: .none, rightNavBarButtonType: .search, customImage: #imageLiteral(resourceName: "ic_logo.png"))
    }
}

// MARK:- Action Methods -
fileprivate extension PatientListViewController {
    
    @IBAction func btnCaseTypeClicked(_ sender: UIButton) {
        
        self.setBarButtonVisibility(isVisible: false)
        self.clearAllAndSelected(buttons: [self.btnActive, self.btnIncoming, self.btnCompleted], selectedButton: sender)

        var x: CGFloat = 0
        
        if sender.tag == 1 {
            x = 0
        } else if sender.tag == 2 {
            x = btnActive.frame.origin.x
        } else if sender.tag == 3 {
            x = btnCompleted.frame.origin.x
        }
        
        UIView.animate(withDuration: 0.22) {
            self.leading_Slider.constant = x
            self.view.layoutIfNeeded()
        }
        
        self.view.endEditing(true)
        self.tblPatientList.reloadData()
    }
}

// MARK:- Private Extension -
fileprivate extension PatientListViewController {
    
    func clearAllAndSelected(buttons: [UIButton], selectedButton: UIButton) {
        
        buttons.forEach { $0.isSelected = false }
        selectedButton.isSelected = true
    }
    
    // Load search bar
    fileprivate func loadSearchBar() {
        
        // Check for navigation bar
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        // Initialise search bar
        self.searchBar = UITextField(frame: .zero)
        
        // Customize
        self.searchBar.backgroundColor = UIColor.white
        self.searchBar.placeholder = "Search Case"
        self.searchBar.returnKeyType = .search
        self.searchBar.clearButtonMode = .whileEditing
        
        // Set hidden
        self.searchBar.isHidden = true
        
        // Add as navigationBar's subview
        navigationBar.addSubview(self.searchBar)
        
        // AutoLayout
        self.searchBar.pinToTopEdgeOfSuperview()
        self.searchBar.pinToSideEdgesOfSuperview(withOffset: 50)
        self.searchBar.pinToBottomEdgeOfSuperview()
        
        // Bind
        self.searchBar.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { _ in
            if !self.searchBar.isHidden {
                self.searchButtonTapped()
            }
        }).disposed(by: self.disposeBag)
    }
    
    // Bar Button Visibility while tap on More Button
    func setBarButtonVisibility(isVisible: Bool) {
        
        if isVisible {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}

// MARK:- Public Extension -
extension PatientListViewController {
    
    
}

// MARK:- Override Methods -
extension PatientListViewController {
    
    // Search button tapped
    override func searchButtonTapped() {
        
        // Load search bar (if needed)
        if self.searchBar == nil {
            self.loadSearchBar()
        }
        
        // Toggle
        self.isInSearchMode = !self.isInSearchMode
        
        // Toggle visibility
        UIView.animate(withDuration: animation_duration, animations: {
            self.searchBar.isHidden = !self.isInSearchMode
        })
        
        // Change search bar icon
        self.navigationItem.rightBarButtonItem?.image = self.isInSearchMode ? #imageLiteral(resourceName: "Cross lines") : #imageLiteral(resourceName: "ic_search.png")
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
        
        // Set first risponder (if needed)
        if self.searchBar.isFirstResponder {
            self.searchBar.resignFirstResponder()
        } else {
            self.searchBar.becomeFirstResponder()
        }
    }
}
