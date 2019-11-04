//
//  CustomScrollView.swift
//  SwipeableView
//
//  Created by William on 04/11/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class CustomScrollView: UIScrollView {
    var customTopView: UIView? {
        didSet {
            if let screen = customTopView {
                superview?.addSubview(screen)
                superview?.sendSubviewToBack(screen)
            }
        }
    }
}
