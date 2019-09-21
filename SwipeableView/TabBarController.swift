//
//  TabBarController.swift
//  SwipeableView
//
//  Created by William on 21/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
  private var homeVC: HomeViewController!
  private var profileVC: ProfileViewController!

  init() {
    homeVC = HomeViewController()
    profileVC = ProfileViewController()

    super.init(nibName: nil, bundle: nil)

    setViewControllers([homeVC,
                        profileVC], animated: true)

    loadTabItem()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func loadTabItem() {
    homeVC.tabBarItem.title = "Home"
    profileVC.tabBarItem.title = "Profile"
  }
}
