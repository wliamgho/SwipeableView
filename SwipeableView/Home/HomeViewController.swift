//
//  HomeViewController.swift
//  SwipeableView
//
//  Created by William on 21/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!

    var currentStreamVC = [UIViewController]()
    private var pageViewController: PageViewController!

    var listData: [String] = ["SLIDE 1", "SLIDE 2", "SLIDE 3", "SLIDE 4"]
    var currentIndex = 0

    // MARK: - Initializer
    init() {
        super.init(nibName: "HomeViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configurePageView()

        pageViewController.didMove(toParent: self)
    }

    private func configurePageView() {
        pageViewController = PageViewController(listData: self.listData)

        var viewPagerFrame = view.frame
        viewPagerFrame.origin.y = headerView.frame.height - 50
        viewPagerFrame.size.height = self.view.frame.height

        addChild(pageViewController)

        pageViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pageViewController.view.frame = viewPagerFrame

        view.addSubview(pageViewController.view)
    }
}
