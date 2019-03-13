//
//  NetworkModule.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 30/09/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class NetworkModule {
    
    // Singleton
    internal static let shared: NetworkModule = NetworkModule()
    
    // Hide init()
    private init() {}
    
    // RxSwift
    fileprivate var disposeBag = DisposeBag()
    
    // Code Stroke Provider
    fileprivate let CodeStrokeProvider: MoyaProvider<CodeStrokeProvider> = MoyaProvider<CodeStrokeProvider>(plugins: [StatusBarActivityIndicatorPlugin()])
}

extension NetworkModule {
    
    func cancelRequest() {
        disposeBag = DisposeBag()
    }
}

// MARK: CodeStrokeProvider (Login)
extension NetworkModule {
    
    // Login
    func login(onSuccess: @escaping (_ response: ApiResponseLogin) -> (),
               onFailure: @escaping (_ reason: FailureReason) -> (),
               onAction: @escaping (_ action: ResponseAction) -> (),
               onError: @escaping (_ error: Error) -> (),
               onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.login).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create ApiResponseLogin object
            guard let apiResponseLogin = ApiResponseLogin(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseLogin.success {
                // Call onSuccess closure with apiResponseLogin object
                onSuccess(apiResponseLogin)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseLogin.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseLogin.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseLogin.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // Register
    func register(username: String, password: String, first_name: String, last_name: String, email: String, role:  String, phone: String,
               onSuccess: @escaping (_ response: ApiResponseLogin) -> (),
               onFailure: @escaping (_ reason: FailureReason) -> (),
               onAction: @escaping (_ action: ResponseAction) -> (),
               onError: @escaping (_ error: Error) -> (),
               onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.register(username: username, password: password, first_name: first_name, last_name: last_name, email: email, role: role, phone: phone)).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create ApiResponseLogin object
            guard let apiResponseLogin = ApiResponseLogin(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseLogin.success {
                // Call onSuccess closure with apiResponseLogin object
                onSuccess(apiResponseLogin)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseLogin.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseLogin.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseLogin.success)
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // Pairing
    func pair(username: String, password: String, pairing_code: String, backend_domain: String, backend_id: String,
               onSuccess: @escaping (_ response: ApiResponsePair) -> (),
               onFailure: @escaping (_ reason: FailureReason) -> (),
               onAction: @escaping (_ action: ResponseAction) -> (),
               onError: @escaping (_ error: Error) -> (),
               onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.pair(username: username, password: password, pairing_code: pairing_code, backend_domain: backend_domain, backend_id: backend_id)).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create ApiResponseLogin object
            guard let apiResponsePair = ApiResponsePair(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponsePair.success {
                // Call onSuccess closure with apiResponseLogin object
                onSuccess(apiResponsePair)
            } else {
                // Check for responseAction
                if let responseAction = apiResponsePair.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponsePair.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponsePair.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    /// Set Password
    func setPassword(password: String,
              onSuccess: @escaping (_ response: ApiResponseBase) -> (),
              onFailure: @escaping (_ reason: FailureReason) -> (),
              onAction: @escaping (_ action: ResponseAction) -> (),
              onError: @escaping (_ error: Error) -> (),
              onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.setPassword(password: password)).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create ApiResponse object
            guard let apiResponseBase = ApiResponseLogin(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseBase.success {
                // Call onSuccess closure with apiResponseLogin object
                onSuccess(apiResponseBase)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseBase.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseBase.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseBase.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // Cases
    func caseList(onSuccess: @escaping (_ response: ApiResponseCaseList) -> (),
               onFailure: @escaping (_ reason: FailureReason) -> (),
               onAction: @escaping (_ action: ResponseAction) -> (),
               onError: @escaping (_ error: Error) -> (),
               onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.caseList).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create ApiResponseCaseList object
            guard let apiResponseCaseList = ApiResponseCaseList(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseCaseList.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseCaseList)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseCaseList.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseCaseList.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseCaseList.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // Delete Case
    func deleteCase(onSuccess: @escaping (_ response: ApiResponseBase) -> (),
                  onFailure: @escaping (_ reason: FailureReason) -> (),
                  onAction: @escaping (_ action: ResponseAction) -> (),
                  onError: @escaping (_ error: Error) -> (),
                  onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.deleteCase).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create ApiResponseBase object
            guard let apiResponseBase = ApiResponseBase(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseBase.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseBase)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseBase.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseBase.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseBase.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // GET ED
    func getEDInfo(onSuccess: @escaping (_ response: ApiResponseEDInfo) -> (),
                  onFailure: @escaping (_ reason: FailureReason) -> (),
                  onAction: @escaping (_ action: ResponseAction) -> (),
                  onError: @escaping (_ error: Error) -> (),
                  onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.getEDInfo).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create apiResponseEDInfo object
            guard let apiResponseEDInfo = ApiResponseEDInfo(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseEDInfo.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseEDInfo)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseEDInfo.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseEDInfo.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseEDInfo.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // SET ED
    func setEDInfo(location: String, registered: Int, triaged: Int, primary_survey: Int, onSuccess: @escaping (_ response: ApiResponseEDInfo) -> (),
                   onFailure: @escaping (_ reason: FailureReason) -> (),
                   onAction: @escaping (_ action: ResponseAction) -> (),
                   onError: @escaping (_ error: Error) -> (),
                   onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.setEDInfo(location: location, registered: registered, triaged: triaged, primary_survey: primary_survey)).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create apiResponseEDInfo object
            guard let apiResponseEDInfo = ApiResponseEDInfo(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseEDInfo.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseEDInfo)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseEDInfo.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseEDInfo.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseEDInfo.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // GET Patient Info
    func getPatientInfo(onSuccess: @escaping (_ response: ApiResponseCaseList) -> (),
                   onFailure: @escaping (_ reason: FailureReason) -> (),
                   onAction: @escaping (_ action: ResponseAction) -> (),
                   onError: @escaping (_ error: Error) -> (),
                   onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.getPatientInfo).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create apiResponseEDInfo object
            guard let apiResponseCaseInfo = ApiResponseCaseList(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseCaseInfo.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseCaseInfo)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseCaseInfo.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseCaseInfo.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseCaseInfo.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // SET Patient Info
    func setPatientInfo(first_name: String, last_name: String, dob: String, address: String, gender: String, last_well: String, nok: String, nok_phone: String, medicare_no: String, hospital_id: String, onSuccess: @escaping (_ response: ApiResponseCaseList) -> (),
                        onFailure: @escaping (_ reason: FailureReason) -> (),
                        onAction: @escaping (_ action: ResponseAction) -> (),
                        onError: @escaping (_ error: Error) -> (),
                        onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.setPatientInfo(first_name: first_name, last_name: last_name, dob: dob, address: address, gender: gender, last_well: last_well, nok: nok, nok_phone: nok_phone, medicare_no: medicare_no, hospital_id: hospital_id)).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create apiResponseEDInfo object
            guard let apiResponseCaseInfo = ApiResponseCaseList(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseCaseInfo.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseCaseInfo)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseCaseInfo.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseCaseInfo.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseCaseInfo.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // GET Clinical Info
    func getClinicalInfo(onSuccess: @escaping (_ response: ApiResponseClinicalInfo) -> (),
                        onFailure: @escaping (_ reason: FailureReason) -> (),
                        onAction: @escaping (_ action: ResponseAction) -> (),
                        onError: @escaping (_ error: Error) -> (),
                        onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.getClinicalInfo).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create apiResponseClinicalInfo object
            guard let apiResponseClinicalInfo = ApiResponseClinicalInfo(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseClinicalInfo.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseClinicalInfo)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseClinicalInfo.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseClinicalInfo.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseClinicalInfo.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // SET Clinical Info
    func setClinicalInfo(pmhx: String, anticoags_last_dose: String, meds: String, anticoags: String, hopc: String, weight: Float, last_meal: String, onSuccess: @escaping (_ response: ApiResponseClinicalInfo) -> (),
                         onFailure: @escaping (_ reason: FailureReason) -> (),
                         onAction: @escaping (_ action: ResponseAction) -> (),
                         onError: @escaping (_ error: Error) -> (),
                         onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.setClinicalInfo(pmhx: pmhx, anticoags_last_dose: anticoags_last_dose, meds: meds, anticoags: anticoags, hopc: hopc, weight: weight, last_meal: last_meal)).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create apiResponseClinicalInfo object
            guard let apiResponseClinicalInfo = ApiResponseClinicalInfo(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseClinicalInfo.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseClinicalInfo)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseClinicalInfo.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseClinicalInfo.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseClinicalInfo.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // GET Clinical Assessment Info
    func getClinicalAssessmentInfo(onSuccess: @escaping(_ response: ApiResponseClinicalAssessmentInfo) -> (),
                         onFailure: @escaping (_ reason: FailureReason) -> (),
                         onAction: @escaping (_ action: ResponseAction) -> (),
                         onError: @escaping (_ error: Error) -> (),
                         onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.getClinicalAssessmentInfo).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create apiResponseClinicalAssessmentInfo object
            guard let apiResponseClinicalAssessmentInfo = ApiResponseClinicalAssessmentInfo(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseClinicalAssessmentInfo.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseClinicalAssessmentInfo)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseClinicalAssessmentInfo.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseClinicalAssessmentInfo.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseClinicalAssessmentInfo.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // SET Clinical Assessment Info
    func setClinicalAssessmentInfo(facial_droop: String, arm_drift: String, weak_grip: String, speech_difficulty: String, bp_systolic: Int, bp_diastolic: Int, heart_rate: Int, heart_rhythm: String, rr: Int, o2sats: Int, temp: Int, gcs: Int, blood_glucose: Int, facial_palsy_race: Int, arm_motor_impair: Int, leg_motor_impair: Int, head_gaze_deviate: Int, hemiparesis: String, cannula: String, conscious_level: Int, month_age: Int, blink_squeeze: Int, horizontal_gaze: Int, visual_fields: Int, facial_palsy_nihss: Int, left_arm_drift: Int, right_arm_drift: Int, left_leg_drift: Int, right_leg_drift: Int, limb_ataxia: Int, sensation: Int, aphasia: Int, dysarthria: Int, neglect: Int, rankin_conscious: Int, likely_lvo: Bool, onSuccess: @escaping(_ response: ApiResponseClinicalAssessmentInfo) -> (),
                                   onFailure: @escaping (_ reason: FailureReason) -> (),
                                   onAction: @escaping (_ action: ResponseAction) -> (),
                                   onError: @escaping (_ error: Error) -> (),
                                   onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.setClinicalAssessmentInfo(facial_droop: facial_droop, arm_drift: arm_drift, weak_grip: weak_grip, speech_difficulty: speech_difficulty, bp_systolic: bp_systolic, bp_diastolic: bp_diastolic, heart_rate: heart_rate, heart_rhythm: heart_rhythm, rr: rr, o2sats: o2sats, temp: temp, gcs: gcs, blood_glucose: blood_glucose, facial_palsy_race: facial_palsy_race, arm_motor_impair: arm_motor_impair, leg_motor_impair: leg_motor_impair, head_gaze_deviate: head_gaze_deviate, hemiparesis: hemiparesis, cannula: cannula, conscious_level: conscious_level, month_age: month_age, blink_squeeze: blink_squeeze, horizontal_gaze: horizontal_gaze, visual_fields: visual_fields, facial_palsy_nihss: facial_palsy_nihss, left_arm_drift: left_arm_drift, right_arm_drift: right_arm_drift, left_leg_drift: left_leg_drift, right_leg_drift: right_leg_drift, limb_ataxia: limb_ataxia, sensation: sensation, aphasia: aphasia, dysarthria: dysarthria, neglect: neglect, rankin_conscious: rankin_conscious, likely_lvo: likely_lvo)).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create apiResponseClinicalAssessmentInfo object
            guard let apiResponseClinicalAssessmentInfo = ApiResponseClinicalAssessmentInfo(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseClinicalAssessmentInfo.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseClinicalAssessmentInfo)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseClinicalAssessmentInfo.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseClinicalAssessmentInfo.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseClinicalAssessmentInfo.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // GET Radiology Info
    func getRadiologyInfo(onSuccess: @escaping (_ response: ApiResponseRadiology) -> (),
                         onFailure: @escaping (_ reason: FailureReason) -> (),
                         onAction: @escaping (_ action: ResponseAction) -> (),
                         onError: @escaping (_ error: Error) -> (),
                         onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.getRadiologyInfo).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create apiResponseClinicalInfo object
            guard let apiResponseRadiologyInfo = ApiResponseRadiology(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseRadiologyInfo.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseRadiologyInfo)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseRadiologyInfo.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseRadiologyInfo.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseRadiologyInfo.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // SET Radiology Info
    func setRadiologyInfo(ct_available: Bool, ct_available_loc: String, arrived_to_ct: Bool, ct_complete: Bool, ich_found: Bool, do_cta_ctp: Bool, cta_ctp_complete: Bool, large_vessel_occlusion: Bool, onSuccess: @escaping (_ response: ApiResponseClinicalInfo) -> (),
                         onFailure: @escaping (_ reason: FailureReason) -> (),
                         onAction: @escaping (_ action: ResponseAction) -> (),
                         onError: @escaping (_ error: Error) -> (),
                         onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.setRadiologyInfo(ct_available: ct_available, ct_available_loc: ct_available_loc, arrived_to_ct: arrived_to_ct, ct_complete: ct_complete, ich_found: ich_found, do_cta_ctp: do_cta_ctp, cta_ctp_complete: cta_ctp_complete, large_vessel_occlusion: large_vessel_occlusion)).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create apiResponseClinicalInfo object
            guard let apiResponseClinicalInfo = ApiResponseClinicalInfo(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseClinicalInfo.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseClinicalInfo)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseClinicalInfo.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseClinicalInfo.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseClinicalInfo.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // GET Management Info
    func getManagementInfo(onSuccess: @escaping (_ response: ApiResponseManagement) -> (),
                          onFailure: @escaping (_ reason: FailureReason) -> (),
                          onAction: @escaping (_ action: ResponseAction) -> (),
                          onError: @escaping (_ error: Error) -> (),
                          onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.getManagementInfo).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create apiResponseManagement object
            guard let apiResponseManagement = ApiResponseManagement(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseManagement.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseManagement)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseManagement.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseManagement.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseManagement.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // SET Management Info
    func setManagementInfo(thrombolysis: Bool, new_trauma_haemorrhage: Bool, uncontrolled_htn: Bool, history_ich: Bool, known_intracranial: Bool, active_bleed: Bool, endocarditis: Bool, bleeding_diathesis: Bool, abnormal_blood_glucose: Bool, rapidly_improving: Bool, recent_trauma_surgery: Bool, recent_active_bleed: Bool, seizure_onset: Bool, recent_arterial_puncture: Bool, recent_lumbar_puncture: Bool, post_acs_pericarditis: Bool, pregnant: Bool, thrombolysis_time_given: String, ecr: Bool, surgical_rx: Bool, conservative_rx: Bool, onSuccess: @escaping (_ response: ApiResponseManagement) -> (),
                          onFailure: @escaping (_ reason: FailureReason) -> (),
                          onAction: @escaping (_ action: ResponseAction) -> (),
                          onError: @escaping (_ error: Error) -> (),
                          onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.setManagementInfo(thrombolysis: thrombolysis, new_trauma_haemorrhage: new_trauma_haemorrhage, uncontrolled_htn: uncontrolled_htn, history_ich: history_ich, known_intracranial: known_intracranial, active_bleed: active_bleed, endocarditis: endocarditis, bleeding_diathesis: bleeding_diathesis, abnormal_blood_glucose: abnormal_blood_glucose, rapidly_improving: rapidly_improving, recent_trauma_surgery: recent_trauma_surgery, recent_active_bleed: recent_active_bleed, seizure_onset: seizure_onset, recent_arterial_puncture: recent_arterial_puncture, recent_lumbar_puncture: recent_lumbar_puncture, post_acs_pericarditis: post_acs_pericarditis, pregnant: pregnant, thrombolysis_time_given: thrombolysis_time_given, ecr: ecr, surgical_rx: surgical_rx, conservative_rx: conservative_rx)).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create apiResponseClinicalInfo object
            guard let apiResponseManagement = ApiResponseManagement(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseManagement.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseManagement)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseManagement.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseManagement.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseManagement.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // SET Case Completed
    func setCaseCompleted(status: String, completed_timestamp: String, onSuccess: @escaping (_ response: ApiResponseBase) -> (), onFailure: @escaping (_ reason: FailureReason) -> (),
                          onAction: @escaping (_ action: ResponseAction) -> (),
                          onError: @escaping (_ error: Error) -> (),
                          onComplete: ((_ success: Bool)->())? = nil) {
        // Make request
        CodeStrokeProvider.rx.request(.caseCompleted(status: status, completed_timestamp: completed_timestamp)).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create apiResponseClinicalInfo object
            guard let apiResponseCaseCompleted = ApiResponseBase(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseCaseCompleted.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseCaseCompleted)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseCaseCompleted.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseCaseCompleted.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseCaseCompleted.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // SET Patient Details
    func setPatientDetails(first_name: String, last_name: String, dob: String, address: String, gender: String, last_well: String, nok: String, nok_phone: String, hospital_id: String, initial_location_lat: String, initial_location_long: String, onSuccess: @escaping (_ response: ApiResponseAddCase) -> (),
                        onFailure: @escaping (_ reason: FailureReason) -> (),
                        onAction: @escaping (_ action: ResponseAction) -> (),
                        onError: @escaping (_ error: Error) -> (),
                        onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.setPatientDetails(first_name: first_name, last_name: last_name, dob: dob, address: address, gender: gender, last_well: last_well, nok: nok, nok_phone: nok_phone, hospital_id: hospital_id, initial_location_lat: initial_location_lat, initial_location_long: initial_location_long)).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create apiResponseEDInfo object
            guard let apiResponseCase = ApiResponseAddCase(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseCase.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseCase)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseCase.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseCase.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseCase.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // SET Clinical History for Paramedic
    func setClinicalHistory(pmhx: String, meds: String, anticoags: String, hopc: String, weight: Float, last_meal: String, onSuccess: @escaping (_ response: ApiResponseBase) -> (),
                               onFailure: @escaping (_ reason: FailureReason) -> (),
                               onAction: @escaping (_ action: ResponseAction) -> (),
                               onError: @escaping (_ error: Error) -> (),
                               onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.setClinicalHistory(pmhx: pmhx, meds: meds, anticoags: anticoags, hopc: hopc, weight: weight, last_meal: last_meal)).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            // Create apiResponseEDInfo object
            guard let apiResponseBase = ApiResponseBase(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseBase.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseBase)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseBase.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseBase.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseBase.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // SET Clinical Assessment for Paramedic
    func setClinicalAssessment(facial_droop: String, arm_drift: String, weak_grip: String, speech_difficulty: String, bp_systolic: String, heart_rate: String, heart_rhythm: String, rr: String, o2sats: String, temp: String, gcs: String, blood_glucose: String, facial_palsy_race: String, arm_motor_impair: String, leg_motor_impair: String, head_gaze_deviate: String, cannula: String, onSuccess: @escaping (_ response: ApiResponseCaseList) -> (),
                           onFailure: @escaping (_ reason: FailureReason) -> (),
                           onAction: @escaping (_ action: ResponseAction) -> (),
                           onError: @escaping (_ error: Error) -> (),
                           onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.setClinicalAssessment(facial_droop: facial_droop, arm_drift: arm_drift, weak_grip: weak_grip, speech_difficulty: speech_difficulty, bp_systolic: bp_systolic, heart_rate: heart_rate, heart_rhythm: heart_rhythm, rr: rr, o2sats: o2sats, temp: temp, gcs: gcs, blood_glucose: blood_glucose, facial_palsy_race: facial_palsy_race, arm_motor_impair: arm_motor_impair, leg_motor_impair: leg_motor_impair, head_gaze_deviate: head_gaze_deviate, cannula: cannula)).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            print(response)
            // Create apiResponseEDInfo object
            guard let apiResponseCaseInfo = ApiResponseCaseList(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseCaseInfo.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseCaseInfo)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseCaseInfo.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseCaseInfo.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseCaseInfo.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
    
    // DropOff for paramedic
    func dropOff(status: String, onSuccess: @escaping (_ response: ApiResponseBase) -> (),
                               onFailure: @escaping (_ reason: FailureReason) -> (),
                               onAction: @escaping (_ action: ResponseAction) -> (),
                               onError: @escaping (_ error: Error) -> (),
                               onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.dropOff(status: status)).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
            print(response)
            // Create apiResponseEDInfo object
            guard let apiResponseBase = ApiResponseBase(dict: response as? NSDictionary) else {
                
                // Create unknown error object
                let userInfo = [NSLocalizedDescriptionKey: "Unknown Error",
                                NSLocalizedFailureReasonErrorKey: "Unknown Error",
                                NSLocalizedRecoverySuggestionErrorKey: "Please check your credentials and try again"]
                let unknownError = NSError(domain: "com.codestroke.codestrokealert", code: 42, userInfo: userInfo)
                
                // Call onError closures with custom error
                onError(unknownError)
                
                // Still completed
                onComplete?(false)
                
                return
            }
            
            // If success
            if apiResponseBase.success {
                // Call onSuccess closure with apiResponseCaseList object
                onSuccess(apiResponseBase)
            } else {
                // Check for responseAction
                if let responseAction = apiResponseBase.responseAction, responseAction != .none {
                    // Call onAction closure with responseAction object
                    onAction(responseAction)
                } else
                    // Check for failureReason
                    if let failureReason = apiResponseBase.failureReason, failureReason != .none {
                        // Call onFailure closure with failureReason object
                        onFailure(failureReason)
                }
            }
            
            // Completed!
            onComplete?(apiResponseBase.success)
            
        }, onError: { error in
            // Call onError closure with error object
            onError(error)
            // Error, but still... Completed!
            onComplete?(false)
        }).disposed(by: disposeBag)
    }
}
