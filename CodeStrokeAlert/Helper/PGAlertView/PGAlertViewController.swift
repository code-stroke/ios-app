//
//  PGAlertView.swift
//  popguide
//
//  Created by Pierluigi Galdi on 27/03/2018.
//  Copyright © 2018 Populi Ltd. All rights reserved.
//

import Foundation
import UIKit
import Lottie
import RxSwift

// Typealias
public typealias PGAlertActionHandler = () -> Void

// Styles
internal enum PGAlertViewControllerStyle {
    case none
    case warning
    case error
    case success
}

public enum PGAlertActionStyle {
    case normal
    case cancel
    case danger
}

// This class represents an action that the user can tap inside a `PGAlertViewController`
open class PGAlertAction: RoundedButton {
    
    // Action
    fileprivate var handler: PGAlertActionHandler?
    
    // Data
    public var title: String! { willSet { setTitle(title, for: .normal) } }
    
    // Initialiser
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(title: String, style: PGAlertActionStyle = .normal, handler: PGAlertActionHandler?) {
        super.init(frame: .zero)
        
        // Set title
        self.setTitle(title, for: .normal)
        
        // Standard customization
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.setTitleColor(.white, for: .normal)
        
        // Customize based on style
        switch style {
        case .normal:
            self.backgroundColor = UIColor.orange
        case .cancel:
            self.backgroundColor = UIColor.orange
        case .danger:
            self.backgroundColor = UIColor.orange
        }
        
        // Add drop shadow
        self.addSoftBackShadow()
        
        // Store handler
        self.handler = handler
        
        // Add target to execute handler on `touchUpInside`
        self.addTarget(self, action: #selector(self.executeHandler), for: .touchUpInside)
    }
    
    /// Private APIs
    private func addSoftBackShadow() {
        self.addDropShadow(offset: .zero, radius: 1.75, color: .black, opacity: 0.18)
    }
    
    /// Execute handler action
    @objc fileprivate func executeHandler() {
        
        // Handler will be executed after a small delay to be sure that `PGAlertViewController` is dismissed before doing anything else
        Utils.execute(after: 0.1, closure: {
            self.handler?()
        })
    }
    
    /// Overrides
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Call super function
        super.touchesBegan(touches, with: event)
        
        // Remove shadow
        self.removeDropShadow()
        
        // Change label opacity
        self.titleLabel?.alpha = 0.18
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Call super function
        super.touchesEnded(touches, with: event)
        
        // Re-add shadow
        self.addSoftBackShadow()
        
        // Change label opacity
        self.titleLabel?.alpha = 1
    }
}

/// This class represent the `PGAlertViewController`
open class PGAlertViewController: UIViewController {
    
    // RxSwift
    fileprivate let disposeBag = DisposeBag()
    
    // Dimension
    private enum Dimension {
        static var width: CGFloat { return (UIScreen.main.bounds.width <= 414) ? (UIScreen.main.bounds.width - 60) : 280 }
        static let padding: CGFloat = 15
        static let buttonHeight: CGFloat = 50
        static let animationHeight: CGFloat = 80
        static let appearAnimationDistance: CGFloat = 300
    }
    
    // Public core data
    var titleText: String? {
        get { return self.titleLabel.text }
        set { self.titleLabel.text = newValue }
    }
    
    var messageText: String? {
        get { return self.messageTextView.text }
        set { self.messageTextView.text = newValue }
    }
    
    // Private core data
    private var style: PGAlertViewControllerStyle = .none
    private var poiSaveButton: PGAlertAction?
    
    /// Private Constraints
    private var contentViewCenterY:         NSLayoutConstraint!
    private var contentViewHeight:          NSLayoutConstraint!
    private var actionsStackViewHeight:     NSLayoutConstraint!
    private var animationViewHeight:        CGFloat = Dimension.animationHeight
    private var animationViewTopPadding:    CGFloat {
        return self.animationViewHeight == 0 ? 16 : 12
    }
    private var messageTextViewHeight: CGFloat = 20
    
    // Private UIs
    private var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        return view
    }()
    
    private var contentView: UIView = {
        let view = RoundedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.cornerRadius = 6
        view.addDropShadow(offset: .zero, radius: 6, color: .black, opacity: 0.3)
        return view
    }()
    
    private var animationView: LOTAnimationView = {
        let view = LOTAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private var messageTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 15, weight: .light)
        textView.textAlignment = .center
        textView.textColor = .darkGray
        textView.isEditable = false
        textView.showsHorizontalScrollIndicator = false
        textView.backgroundColor = .clear
        textView.isSelectable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    /// Initialiser
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Create a `PGAlertViewController` with specified title, message and style
    // FIXME: PersonalPoi was updated to UserPoi, check for implications
    internal init(title: String?, message: String?, style: PGAlertViewControllerStyle = .none, dismissable: Bool = true, actions: [PGAlertAction] = []) {
        
        // Super init!
        super.init(nibName: nil, bundle: nil)
        
        // Store data
        self.style = style
        self.titleText = title
        
        // Check for message
        if let message = message { self.messageText = message }else { self.messageTextViewHeight = 0 }
        
        // Set animation
        switch style {
        case .none:
            self.animationViewHeight = 0
        case .warning:
            self.animationView.setAnimation(named: "warning")
        case .error:
            self.animationView.setAnimation(named: "loader_success_failed")
        case .success:
            self.animationView.setAnimation(named: "success")
        }
        
        // Build UI
        self.buildUI()
        
        // Add dismiss tap gesture
        if dismissable {
            self.addDismissTapGesture()
        }
        
        // Add actions
        switch self.style {
        default:
            actions.forEach({ action in
                self.add(action: action)
            })
        }
        
        // Subscribe to keyboard height
        RxKeyboard.instance.visibleHeight.drive(onNext: { keyboardHeight in
            /// Set constant
            self.contentViewCenterY.constant -= (keyboardHeight / 2)
            /// Animate
            UIView.animate(withDuration: 0.25, animations: { self.view.layoutIfNeeded() })
        }).disposed(by: self.disposeBag)
    }
    
    /// Private APIs
    private func addDismissTapGesture() {
        
        // Create gesture recognizer
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAnimated))
        
        // Add recognizer to shadow view only
        self.shadowView.addGestureRecognizer(gesture)
    }
    
    private func buildUI() {
        
        // Set custom transition
        self.modalPresentationStyle = .custom
        self.modalTransitionStyle = .crossDissolve
        
        // Layout UI elements
        self.layoutUIElements()
    }
    
    private func layoutUIElements() {
        
        // Add content view as subview to main view
        self.view.addSubview(self.contentView)
        self.view.insertSubview(self.shadowView, at: 0)
        
        // Add UI elements view as subview to content view
        self.contentView.addSubview(self.animationView)
        self.contentView.addSubview(self.titleLabel)
        switch self.style {
        
        default:
            self.contentView.addSubview(self.messageTextView)
        }
        self.contentView.addSubview(self.actionsStackView)
        
        // Add `shadowView` constraints
        self.shadowView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.shadowView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.shadowView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.shadowView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // Add `contentView` constraints
        self.contentViewCenterY = self.contentView.centerYAnchor.constraint(equalTo: self.shadowView.centerYAnchor, constant: Dimension.appearAnimationDistance)
        self.contentViewCenterY.isActive = true
        self.contentView.centerXAnchor.constraint(equalTo: self.shadowView.centerXAnchor).isActive = true
        self.contentView.widthAnchor.constraint(equalToConstant: Dimension.width).isActive = true
        self.contentViewHeight = self.contentView.heightAnchor.constraint(lessThanOrEqualToConstant: self.view.bounds.height - 80)
        self.contentViewHeight.isActive = true
        
        // Add `animationView` constraints
        self.animationView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: self.animationViewTopPadding).isActive = true
        self.animationView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Dimension.padding).isActive = true
        self.animationView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Dimension.padding).isActive = true
        self.animationView.heightAnchor.constraint(equalToConstant: self.animationViewHeight).isActive = true
        
        // Add `titleLabel` constraints
        self.titleLabel.topAnchor.constraint(equalTo: self.animationView.bottomAnchor, constant: 8).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Dimension.padding).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Dimension.padding).isActive = true
        self.titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        self.titleLabel.sizeToFit()
        
        // Check for alert style
        switch self.style {
        
        // DEFAULT
        default:
            
            // Add `messageTextView` constraints
            self.messageTextView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
            self.messageTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Dimension.padding).isActive = true
            self.messageTextView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Dimension.padding).isActive = true
            self.messageTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: self.messageTextViewHeight).isActive = true
            self.messageTextView.sizeToFit()
            
            // Action stack view
            self.actionsStackView.topAnchor.constraint(equalTo: self.messageTextView.bottomAnchor, constant: 20).isActive = true
        }
        
        // Add `actionsStackView` constraints
        self.actionsStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Dimension.padding).isActive = true
        self.actionsStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Dimension.padding).isActive = true
        self.actionsStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12).isActive = true
        self.actionsStackViewHeight = self.actionsStackView.heightAnchor.constraint(equalToConstant: Dimension.buttonHeight * CGFloat(self.actionsStackView.arrangedSubviews.count))
        self.actionsStackViewHeight.isActive = true
    }
    
    /// Fileprivate APIs
    @objc fileprivate func dismissAnimated() {
        self.dismiss(animated: true, completion: nil)
    }
}

/// Overrides
extension PGAlertViewController {

    /// View did appear
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Play animation
        switch self.style {
        case .error:
            self.animationView.play(fromProgress: 0.815, toProgress: 0.98, withCompletion: nil)
        default:
            self.animationView.play()
        }
    }
    
    /// View did layout subviews
    override open func viewDidLayoutSubviews() {
        
        // Enable scroll based on height
        if self.contentView.bounds.height >= UIScreen.main.bounds.height - 80 { self.messageTextView.isScrollEnabled = true }
        
        // Animate in
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.25, options: .curveEaseInOut, animations: {
            let transform = CGAffineTransform(translationX: 0, y: -Dimension.appearAnimationDistance)
            self.contentView.transform = transform
        }, completion: nil)
    }
    
    /// View will disappear
    override open func viewWillDisappear(_ animated: Bool) {
        
        // Animate out
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.25, options: .curveEaseInOut, animations: {
            let transform = CGAffineTransform(translationX: 0, y: Dimension.appearAnimationDistance)
            self.contentView.transform = transform
        }, completion: nil)
    }
    
    /// View will transition
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.contentViewHeight.constant = size.height - 80
        self.contentView.layoutIfNeeded()
    }
}

/// Actions
extension PGAlertViewController {
    
    /// Add an action
    open func add(action: PGAlertAction) {
        
        // Add action to stackView
        self.actionsStackView.addArrangedSubview(action)
        
        // Check if should be horizontal or vertical (based on how many arranged subviews there are)
        if self.actionsStackView.arrangedSubviews.count > 2 {
            self.actionsStackView.axis = .vertical
            self.actionsStackViewHeight.constant = Dimension.buttonHeight * CGFloat(self.actionsStackView.arrangedSubviews.count)
            self.actionsStackView.spacing = 8
        } else {
            self.actionsStackViewHeight.constant = Dimension.buttonHeight
            self.actionsStackView.axis = .horizontal
            self.actionsStackView.spacing = 15
        }
        
        // Set corner radius
        action.cornerRadius = Dimension.buttonHeight / 2
        
        // Add target for dismiss
        action.addTarget(self, action: #selector(self.dismissAnimated), for: .touchUpInside)
    }
}

/// UITextViewDelegate
extension PGAlertViewController: UITextViewDelegate {
    
    /// Did begin editing
    public func textViewDidBeginEditing(_ textView: UITextView) {
        
        // Check text color
        if textView.textColor == UIColor.orange {
            textView.text = nil
            textView.textColor = .darkGray
        }
    }
    
    /// Did end editing
    public func textViewDidEndEditing(_ textView: UITextView) {
        /// Check text lenght
        if textView.text.isEmpty {
            textView.text = "Add custom point description...\n(optional)"
            textView.textColor = UIColor.orange
        }
    }
}
