//
//  HomeViewController.swift
//  SwipeableView
//
//  Created by William on 21/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  @IBOutlet weak var swipeableCardView: SwipeableCardView!

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    swipeableCardView.updateData = ["test 1", "test 2", "test 3", "test 4", "test 5", "test 6", "test 7"]
  }
}
