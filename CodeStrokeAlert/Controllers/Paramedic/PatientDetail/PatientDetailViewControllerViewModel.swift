//
//  PatientDetailViewControllerViewModel.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 04/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import RxSwift

// MARK:- Model for required methods -
protocol PatientDetailViewControllerViewModel {
    
    
}

// MARK:- ModelImplementation -
class PatientDetailViewControllerViewModelImplementation: PatientDetailViewControllerViewModel {
    
    // View Object
    let view: PatientDetailViewController!
    
    // Initilize
    init(_ view: PatientDetailViewController) {
        self.view = view
    }
}
