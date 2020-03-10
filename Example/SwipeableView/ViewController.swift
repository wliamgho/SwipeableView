//
//  ViewController.swift
//  SwipeableView
//
//  Created by William on 03/10/2020.
//  Copyright (c) 2020 William. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  private var testView: TestView!

  override func viewDidLoad() {
    super.viewDidLoad()

    testView = TestView()

    self.view.addSubview(testView)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

