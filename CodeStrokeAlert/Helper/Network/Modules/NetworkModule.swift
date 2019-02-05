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
    func login(username: String, password: String,
               onSuccess: @escaping (_ response: ApiResponseLogin) -> (),
               onFailure: @escaping (_ reason: FailureReason) -> (),
               onAction: @escaping (_ action: ResponseAction) -> (),
               onError: @escaping (_ error: Error) -> (),
               onComplete: ((_ success: Bool)->())? = nil) {
        
        // Make request
        CodeStrokeProvider.rx.request(.login(username: username, password: password)).mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
            
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
}
