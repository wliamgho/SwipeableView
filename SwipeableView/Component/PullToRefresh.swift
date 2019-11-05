//
//  PullToRefresh.swift
//  SwipeableView
//
//  Created by William on 05/11/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

protocol PullToRefreshDelegate: class {
  func beginRefreshing()
}

class PullToRefresh: UIRefreshControl {
  weak var delegate: PullToRefreshDelegate?

  override init() {
    super.init()

    configureLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureLayout() {
    self.bounds = CGRect(x: self.frame.origin.x,
                         y: self.frame.origin.y + 60,
                         width: self.frame.width,
                         height: self.frame.height)

    self.layer.zPosition = 0
    self.addTarget(self, action: #selector(self.handleRefresh(_:)), for: .valueChanged)
  }

  @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
    delegate?.beginRefreshing()
  }

  override func endRefreshing() {
    super.endRefreshing()
  }
}
