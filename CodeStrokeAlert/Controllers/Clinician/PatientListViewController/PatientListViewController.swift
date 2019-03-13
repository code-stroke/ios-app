//
//  PatientListViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 09/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit

class PatientListCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblETA: UILabel!
}

// MARK:- Outlets and Properties -
class PatientListViewController: BaseViewController {
    
    @IBOutlet weak var lblEmptyData: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tblPatientList: UITableView!
    @IBOutlet weak var btnIncoming: UIButton!
    @IBOutlet weak var btnActive: UIButton!
    @IBOutlet weak var btnCompleted: UIButton!
    @IBOutlet weak var leading_Slider: NSLayoutConstraint!
    
    // SearchBar
    fileprivate var searchBar:                  UITextField!
    fileprivate var isInSearchMode:             Bool            = false
    fileprivate let animation_duration:         TimeInterval    = 0.35
    
    fileprivate var caseList: [Case] = []
    
    fileprivate var filteredCaseList: [Case] = [] {
        didSet {
            self.tblPatientList.reloadData()
        }
    }
}

// MARK:- ViewController LifeCycle -
extension PatientListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Initialize
        self.initialise(withNavBarStyle: .standard, leftNavBarButtonType: .none, rightNavBarButtonType: .add, customImage: #imageLiteral(resourceName: "ic_logo.png"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.22) {
            self.clearAllAndSelected(buttons: [self.btnActive, self.btnIncoming, self.btnCompleted], selectedButton: self.btnIncoming)
            self.leading_Slider.constant = 0
            self.view.layoutIfNeeded()
        }
        NetworkModule.shared.caseList(onSuccess: { apiResponseCaseList in
            
            print(apiResponseCaseList)
            self.caseList = apiResponseCaseList.caseArray
            self.filteredCaseList = self.filter(byCaseType: "incoming")
            CasesManager.add(cases: self.caseList)
            
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
            
            self.activityIndicator.stopAnimating()
        })
    }
}

// MARK:- Action Methods -
fileprivate extension PatientListViewController {
    
    @IBAction func btnCaseTypeClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnActive, self.btnIncoming, self.btnCompleted], selectedButton: sender)

        var x: CGFloat = 0
        
        if sender.tag == 1 {
            x = 0
            self.filteredCaseList = self.filter(byCaseType: "incoming")
        } else if sender.tag == 2 {
            x = btnActive.frame.origin.x
            self.filteredCaseList = self.filter(byCaseType: "active")
        } else if sender.tag == 3 {
            x = btnCompleted.frame.origin.x
            self.filteredCaseList = self.filter(byCaseType: "completed")
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
    
    func filter(byCaseType caseType: String) -> [Case] {
        
        return self.caseList.filter { $0.status == caseType }
    }
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

// MARK:- TableView Delegate & DataSource -
extension PatientListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.filteredCaseList.count > 0 {
            self.lblEmptyData.isHidden = true
            return self.filteredCaseList.count
        } else {
            self.lblEmptyData.isHidden = false
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PatientListCell = tableView.dequeueReusableCell(withIdentifier: "PatientListCell", for: indexPath) as! PatientListCell
        cell.lblName.text = "\(self.filteredCaseList[indexPath.row].first_name == "unknown" ? "" : self.filteredCaseList[indexPath.row].first_name ?? "") \(self.filteredCaseList[indexPath.row].last_name == "unknown" ? "" : self.filteredCaseList[indexPath.row].last_name ?? "")"
        cell.lblGender.text = self.filteredCaseList[indexPath.row].gender == "f" ? "Female" : "Male"
        
        if let dob = self.filteredCaseList[indexPath.row].dob {
            let strDOB = self.calcAge(birthday: dob)
            cell.lblAge.text = "\(strDOB)"
        }
        
        cell.lblETA.text = ""
        
        if let etaDate = self.filteredCaseList[indexPath.row].eta, etaDate != "" {
            if let date = etaDate.toDate("yyyy-MM-dd HH:mm") {
                cell.lblETA.text = date.toString("dd, MMM yyyy hh:mm a")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !self.btnCompleted.isSelected {
            let clinicianNavigation: MainContainerViewController = UIStoryboard.storyboard(.clinician).instantiate()
            PrefsManager.setCaseID(userId: self.filteredCaseList[indexPath.row].case_id)
            clinicianNavigation.selectedCase = self.filteredCaseList[indexPath.row]
            self.navigate(to: clinicianNavigation)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            // Create actions
            let cancel = PGAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let delete = PGAlertAction(title: "Delete", style: .danger, handler: {
                
                self.activityIndicator.startAnimating()
                
                PrefsManager.setCaseID(userId: self.filteredCaseList[indexPath.row].case_id)
                
                NetworkModule.shared.deleteCase(onSuccess: { apiResponse in
                    
                    if apiResponse.success {
                        PrefsManager.clearCaseID()
                        self.filteredCaseList.remove(at: indexPath.row)
                        self.tblPatientList.reloadData()
                    } else {
                        
                    }
                    
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
                    self.activityIndicator.stopAnimating()
                })
            })
            
            // Create controller
            let alertController = PGAlertViewController(title: "CodeStrokeAlert", message: "Are you sure you want to delete this case?", style: .none, dismissable: true, actions: [cancel, delete])
            
            // Show alert controller
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}
