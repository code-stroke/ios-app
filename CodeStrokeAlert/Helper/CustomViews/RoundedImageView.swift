//
//  RoundedImageView.swift
//  popguide
//
//  Created by Sumit Anantwar on 29/08/2018.
//  Copyright © 2018 Populi Ltd. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedImageView: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

}
