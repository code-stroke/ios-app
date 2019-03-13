//
//  PatientListViewControllerViewModel.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 09/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import RxSwift

// MARK:- Model for required methods -
protocol PatientListViewControllerViewModel {
    
    func filter(byCaseType caseType: String)
}

// MARK:- Extension of Model for optional methods -
extension PatientListViewControllerViewModel {
    
    
}

// MARK:- ModelImplementation -
class PatientListViewControllerViewModelImplementation: PatientListViewControllerViewModel {
    
    func filter(byCaseType caseType: String) {
        
    }
}
