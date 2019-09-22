//
//  PagedStreamView.swift
//  SwipeableView
//
//  Created by William on 22/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

protocol PagedStreamView: class {
  var currentPage: Int { get }

  func setPage(_ page: Int)
}
