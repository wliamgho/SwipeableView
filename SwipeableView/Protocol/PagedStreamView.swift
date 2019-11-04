//
//  PagedStreamView.swift
//  SwipeableView
//
//  Created by William on 22/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

protocol PagedStreamView: class {
    var currentPage: Int { get }

    var currentView: UIView { get }
}
