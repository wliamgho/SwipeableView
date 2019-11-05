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
    @IBOutlet weak var scrollView: CustomScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var statusBarView: UIView!

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!

    var currentStreamVC = [UIViewController]()
    private var pageViewController: PageViewController!

    private(set) var pullToRefresh = PullToRefresh()

    var listData: [String] = ["SLIDE 1", "SLIDE 2", "SLIDE 3", "SLIDE 4", "List"]
    var lastPosY: CGFloat = 0
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

        configureHeaderView()

        configurePageView()

        pageViewController.didMove(toParent: self)

        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        scrollView.scrollIndicatorInsets = scrollView.contentInset

        if let screen = pageViewController.controller.currentView as? UIView {
            debugPrint(pageViewController.controller)
            if pageViewController.controller is ScreenViewController {
                contentView.backgroundColor = .blue
            } else if pageViewController.controller is ListViewController {
                contentView.backgroundColor = .green
            }
        }

        scrollView.refreshControl = pullToRefresh
        pullToRefresh.delegate = self
    }

    private func configurePageView() {
        pageViewController = PageViewController(listData: self.listData)
        pageViewController.pageDelegate = self

        var viewPagerFrame = view.frame
        viewPagerFrame.origin.y = headerView.frame.height - 80
        viewPagerFrame.size.height = 200

        pageViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pageViewController.view.frame = viewPagerFrame

        scrollView.addSubview(pageViewController.view)

        lastPosY += headerView.frame.height

        contentHeightConstraint.constant = lastPosY
    }

    private func configureHeaderView() {
        scrollView.customTopView = headerView
        lastPosY += headerView.frame.height

        contentHeightConstraint.constant = lastPosY
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let contentOffsetY = abs(min(0, scrollView.contentOffset.y))
//        let percentage = contentOffsetY / scrollView.contentInset.top
        let contentOffset = scrollView.contentOffset.y

        if scrollView.contentOffset.y < 0 {
            // Scroll down
            debugPrint("scroll down")
        } else if scrollView.contentOffset.y == 0 {
            // default
            debugPrint("default")
        } else {
            // Scroll top
            debugPrint("scroll up")
        }
    }
}

extension HomeViewController: PageViewDelegate {
    func pageIndex(withIndex index: Int) {
    }
    func pageViewDidSwap() {
        scrollView.setContentOffset(.zero, animated: true)
    }
}

extension HomeViewController: PullToRefreshDelegate {
    func beginRefreshing() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          self.pullToRefresh.endRefreshing()
        }
    }
}
