//
//  RegisterViewController.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 14/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit
import AVFoundation
import EVReflection
import SwiftOTP

class EnteredCreds: EVObject {
    
    var username: String            = ""
    var password: String            = ""
}

class TokenInfo: EVObject {
    
    var username: String            = ""
    var userpass: String            = ""
    var password: String            = ""
    var token: String               = ""
    var shared_secret: String       = ""
}

// MARK:- Outlets and Properties -
class RegisterViewController: BaseViewController {
    
    let captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    var strJsonValue: String =  ""
}

// MARK:- ViewController LifeCycle -
extension RegisterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Initialize Navigation
        self.initialise(withNavBarStyle: .standard, leftNavBarButtonType: .back, rightNavBarButtonType: .none, customImage: #imageLiteral(resourceName: "ic_logo.png"))
        
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            //already authorized
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    //access allowed
                } else {
                    self.checkCamera()
                }
            })
        }
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            self.captureSession.startRunning()
            
            qrCodeFrameView = UIView()

            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubviewToFront(qrCodeFrameView)
            }
        } catch {
            print(error)
            return
        }
    }
    
    func checkCamera() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized: checkCamera() // Do your stuff here i.e. callCameraMethod()
        case .denied: alertPromptToAllowCameraAccessViaSetting()
        case .notDetermined: alertToEncourageCameraAccessInitially()
        default: alertToEncourageCameraAccessInitially()
        }
    }
    
    func alertToEncourageCameraAccessInitially() {
        let alert = UIAlertController(
            title: "CodeStrokeAlert",
            message: "Camera access required for scan QR code",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func alertPromptToAllowCameraAccessViaSetting() {
        
        let alert = UIAlertController(
            title: "CodeStrokeAlert",
            message: "Camera access required for scan QR code",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel) { alert in
            UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
            }
        )
        present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
}

// MARK:- Private Extension -
private extension RegisterViewController {
    
    
}

// MARK:- Public Extension -
extension RegisterViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {

                if let jsonString = metadataObj.stringValue?.replacingOccurrences(of: "\\", with: "") {
                    
                    if strJsonValue == "" {
                        
                        strJsonValue = jsonString.replacingOccurrences(of: "\"{", with: "{")
                        strJsonValue = strJsonValue.replacingOccurrences(of: "}\"", with: "}")
                        
                        if let dict = convertToDictionary(text: strJsonValue) {
                           
                            NetworkModule.shared.pair(username: dict["username"] ?? "", password: dict["password"] ?? "", pairing_code: dict["pairing_code"] ?? "", backend_domain: dict["backend_domain"] ?? "", backend_id: dict["backend_id"] ?? "", onSuccess: { apiResponsePair in
                                print(apiResponsePair)
                                
                                let tokenInfo           = TokenInfo()
                                tokenInfo.username      = dict["username"] ?? ""
                                tokenInfo.password      = dict["password"] ?? ""
                                
                                let data = apiResponsePair.shared_secret.base32DecodedData
                                let totp = TOTP(secret: data!, digits: 6, timeInterval: 300, algorithm: .sha1)!
                                let token = totp.generate(time: Date())
                                tokenInfo.token          = token
                                tokenInfo.shared_secret  = apiResponsePair.shared_secret
                                PrefsManager.saveData(for: TOKENINFO, and: tokenInfo)
                                
                                UserDefaults.standard.set(true, forKey: "PASSWORD")
                                
                                self.navigationController?.navigationBar.isHidden = false
                                let passwordVC: PasswordViewController = UIStoryboard.storyboard(.password).instantiate()
                                self.navigate(to: passwordVC)
                                UserDefaults.standard.set(false, forKey: "PASSWORD")
                                
                            }, onFailure: { failureReason in
                                
                                // Switch failure reason
                                print(failureReason)
                                // Create Alert Controller
                                let alertController = PGAlertViewController(title: "CodeStrokeAlert", message: "Authentication failed. Please contact codestrokealert@gmail.com for assistance.", style: .error, dismissable: false, actions: [PGAlertAction(title: "OK", style: .normal, handler: {
                                    self.navigationController?.popViewController(animated: true)
                                }) ])
                                
                                // Show alert controller
                                self.present(alertController, animated: true, completion: nil)
                                
                            }, onAction: { responseAction in
                                
                                // Show alert for response action
                                if responseAction == .actionUpdate {
                                    
                                }
                                
                            }, onError: { error in
                                // Show alert for error
                            }, onComplete: { success in
                                
                                if success == false {
                                    // Create Alert Controller
                                    let alertController = PGAlertViewController(title: "CodeStrokeAlert", message: "Authentication failed. Please contact codestrokealert@gmail.com for assistance.", style: .error, dismissable: false, actions: [PGAlertAction(title: "OK", style: .normal, handler: {
                                        self.navigationController?.popViewController(animated: true)
                                    }) ])
                                    
                                    // Show alert controller
                                    self.present(alertController, animated: true, completion: nil)
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
    func convertToDictionary(text: String) -> [String: String]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String : String]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
