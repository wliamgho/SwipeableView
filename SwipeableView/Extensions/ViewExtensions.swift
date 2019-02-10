//
//  ViewExtensions.swift
//  SwipeableView
//
//  Created by William on 09/02/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

extension UIView {
    static func instantiateFromNib<T: UIView>(viewType: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as! T
    }

    static func instantiateFromNib() -> Self {
        return instantiateFromNib(viewType: self)
    }
}
