//
//  FirstViewController.swift
//  SwipeableView
//
//  Created by William on 09/02/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
