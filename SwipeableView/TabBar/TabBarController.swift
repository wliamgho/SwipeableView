//
//  TabBarController.swift
//  SwipeableView
//
//  Created by William on 12/02/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

enum TabIndex: Int {
    case first = 1
    case second = 2
}

class TabBarController: UITabBarController {
    var firstVC: ParentViewController
    var secondVC: ParentViewController

    init() {
        firstVC = ParentViewController(withTabIndex: .first)
        secondVC = ParentViewController(withTabIndex: .second)

        super.init(nibName: nil, bundle: nil)

        let viewControllers: [UIViewController] = [
            firstVC, secondVC
        ]

        setViewControllers(viewControllers, animated: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        firstVC.tabBarItem.title = "First"
        secondVC.tabBarItem.title = "Second"
    }

    
}
