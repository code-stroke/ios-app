//
//  RadiologyInfoView.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 25/11/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import UIKit

protocol RadiologyInfoViewDelegate {
    
    func showAlert(withTitle title: String, andMessage message: String, isSuccess: Bool)
}

class RadiologyInfoView: UIView {
    
    @IBOutlet var container: UIView!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var btnCTAvailableYes: UIButton!
    @IBOutlet weak var btnCTAvailableNo: UIButton!
    
    @IBOutlet weak var txtLocation: UITextField!
    
    @IBOutlet weak var btnPtArriveInCTYes: UIButton!
    @IBOutlet weak var btnPtArriveInCT2No: UIButton!
    
    @IBOutlet weak var btnCTCompleteYes: UIButton!
    @IBOutlet weak var btnCTCompleteNo: UIButton!
    
    @IBOutlet weak var btnICHCTYes: UIButton!
    @IBOutlet weak var btnICHCTNo: UIButton!
    
    @IBOutlet weak var btnProceedCTAorCTPYes: UIButton!
    @IBOutlet weak var btnProceedCTAorCTPNo: UIButton!
    
    @IBOutlet weak var btnCTAorCTPCompleteYes: UIButton!
    @IBOutlet weak var btnCTAorCTPCompleteNo: UIButton!
    
    @IBOutlet weak var btnLargeVesselOcclusionYes: UIButton!
    @IBOutlet weak var btnLargeVesselOcclusionNo: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Delegate
    var delegate: RadiologyInfoViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initilize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initilize()
    }
    
    override var frame: CGRect {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.container.frame = self.bounds
    }
    
    func initilize() {
        
        Bundle.main.loadNibNamed(String(describing: RadiologyInfoView.self), owner: self, options: nil)
        self.container.frame = self.bounds
        self.addSubview(self.container)
        self.clipsToBounds = true
        
        // Setup Submit Button With Gradient Image
        self.setGradientToButton(for: self.btnSubmit, with: 12.0)
        
        // Call Webservice
        self.getRadiologyInfo()
    }
}

// MARK:- Custom Methods -
extension RadiologyInfoView {
    
    func getRadiologyInfo() {
        
        self.activityIndicator.startAnimating()
        
        NetworkModule.shared.getRadiologyInfo(onSuccess: { apiResponseRadiology in
            print(apiResponseRadiology)
            
            self.setWebserviceData(RadiologyInfo: apiResponseRadiology.radiologyInfoArray[0])
            
        }, onFailure: { failureReason in
        }, onAction: { responseAction in
        }, onError: { error in
        }, onComplete: { success in
            self.activityIndicator.stopAnimating()
        })
    }
    
    func clearAllAndSelected(buttons: [UIButton], selectedButton: UIButton?) {
        
        buttons.forEach { $0.isSelected = false }
        
        guard let btn = selectedButton else {
            return
        }
        
        btn.isSelected = true
    }
    
    func setWebserviceData(RadiologyInfo data: RadiologyInfo) {
        
        if let ct_available_location = data.ct_available_loc {
            self.txtLocation.text = ct_available_location
        }
        
        self.clearAllAndSelected(buttons: [self.btnCTAvailableYes, self.btnCTAvailableNo], selectedButton: data.ct_available ? self.btnCTAvailableYes : self.btnCTAvailableNo)
        
        self.clearAllAndSelected(buttons: [self.btnPtArriveInCTYes, self.btnPtArriveInCT2No], selectedButton: data.arrived_to_ct ? self.btnPtArriveInCTYes : self.btnPtArriveInCT2No)
        
        self.clearAllAndSelected(buttons: [self.btnCTCompleteYes, self.btnCTCompleteNo], selectedButton: data.ct_complete ? self.btnCTCompleteYes : self.btnCTCompleteNo)
        
        self.clearAllAndSelected(buttons: [self.btnICHCTYes, self.btnICHCTNo], selectedButton: data.ich_found ? self.btnICHCTYes : self.btnICHCTNo)
        
        self.clearAllAndSelected(buttons: [self.btnProceedCTAorCTPYes, self.btnProceedCTAorCTPNo], selectedButton: data.do_cta_ctp ? self.btnProceedCTAorCTPYes : self.btnProceedCTAorCTPNo)
        
        self.clearAllAndSelected(buttons: [self.btnCTAorCTPCompleteYes, self.btnCTAorCTPCompleteNo], selectedButton: data.cta_ctp_complete ? self.btnCTAorCTPCompleteYes : self.btnCTAorCTPCompleteNo)
        
        self.clearAllAndSelected(buttons: [self.btnLargeVesselOcclusionYes, self.btnLargeVesselOcclusionNo], selectedButton: data.large_vessel_occlusion ? self.btnLargeVesselOcclusionYes : self.btnLargeVesselOcclusionNo)
    }
}

// MARK:- Action Methods -
extension RadiologyInfoView {
    
    @IBAction func btnCTAvailableClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnCTAvailableYes, self.btnCTAvailableNo], selectedButton: sender)
    }
    
    @IBAction func btnPTinCTClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnPtArriveInCTYes, self.btnPtArriveInCT2No], selectedButton: sender)
    }
    
    @IBAction func btnCTCompleteClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnCTCompleteYes, self.btnCTCompleteNo], selectedButton: sender)
    }
    
    @IBAction func btnICHClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnICHCTYes, self.btnICHCTNo], selectedButton: sender)
    }
    
    @IBAction func btnProceedWithCTAClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnProceedCTAorCTPYes, self.btnProceedCTAorCTPNo], selectedButton: sender)
    }
    
    @IBAction func btnCTAorCTPCompleteClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnCTAorCTPCompleteYes, self.btnCTAorCTPCompleteNo], selectedButton: sender)
    }
    
    @IBAction func btnLargeVesselClicked(_ sender: UIButton) {
        
        self.clearAllAndSelected(buttons: [self.btnLargeVesselOcclusionYes, self.btnLargeVesselOcclusionNo], selectedButton: sender)
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        self.activityIndicator.startAnimating()
        
        NetworkModule.shared.setRadiologyInfo(ct_available: self.btnCTAvailableYes.isSelected ? true : false, ct_available_loc: isEmptyString(self.txtLocation.text!) ? "" : self.txtLocation.text!, arrived_to_ct: self.btnPtArriveInCTYes.isSelected ? true : false, ct_complete: self.btnCTCompleteYes.isSelected ? true : false, ich_found: self.btnICHCTYes.isSelected ? true : false, do_cta_ctp: self.btnProceedCTAorCTPYes.isSelected ? true : false, cta_ctp_complete: self.btnCTAorCTPCompleteYes.isSelected ? true : false, large_vessel_occlusion: self.btnLargeVesselOcclusionYes.isSelected ? true : false, onSuccess: { apiResponseRadiology in
            
            print(apiResponseRadiology)
            
        }, onFailure: { failureReason in
            
        }, onAction: { responseAction in
            
        }, onError: { error in
            // Show alert for error
        }, onComplete: { success in
            
            // Show Alert
            if success {
                self.delegate?.showAlert(withTitle: "CodeStrokeAlert", andMessage: "Submitted successfully", isSuccess: true)
            } else {
                self.delegate?.showAlert(withTitle: "CodeStrokeAlert", andMessage: "Error while submitting data", isSuccess: false)
            }
            
            self.activityIndicator.stopAnimating()
        })
    }
}
