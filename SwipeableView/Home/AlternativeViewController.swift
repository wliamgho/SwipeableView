//
//  AlternativeViewController.swift
//  SwipeableView
//
//  Created by William on 05/11/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class AlternativeViewController: UIViewController {
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var contentTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!

    private(set) var pullToRefresh = PullToRefresh()
    private var viewPager: PageViewController!

    var index = 0

    var listData: [String] = ["SLIDE 1", "SLIDE 2", "SLIDE 3", "SLIDE 4", "List"]
    var itemData = ["test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test"]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionLayout()

        configureViewPager()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewPager.didMove(toParent: self)
    }

    private func configureCollectionLayout() {
        var contentInset = UIEdgeInsets(top: 200,
                                        left: 0, bottom: 44, right: 0)
        if #available(iOS 11.0, *), let window = UIApplication.shared.keyWindow {
            contentInset.top -= (window.safeAreaInsets.top)
        }

        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        scrollView.refreshControl = pullToRefresh
        scrollView.delegate = self
        pullToRefresh.delegate = self

//        headerView.observeOn(controller: self)
        headerView.observeOn(scrollView: scrollView)
    }

    private func configureViewPager() {
        viewPager = PageViewController(listData: listData)
        viewPager.pageDelegate = self
        viewPager.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewPager.view.frame = contentView.frame
        contentView.addSubview(viewPager.view)

        contentHeightConstraint.constant += CGFloat(itemData.count * 200)
    }
}

extension AlternativeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = abs(min(0, scrollView.contentOffset.y))
        let percentage = contentOffsetY / scrollView.contentInset.top

        debugPrint("percentage", percentage)

        if percentage > 1.0 {
            // Scroll down
            debugPrint("scroll down")
        } else {
            // Scroll top
            debugPrint("scroll top")
//            contentTopConstraint.constant = 0
        }
    }
}

extension AlternativeViewController: PageViewDelegate {
    func pageViewDidSwap() {
        scrollView.setContentOffset(CGPoint(x: 0, y: -200), animated: true)
    }

    func pageIndex(withIndex index: Int) {
    }
}

// MARK: - PullToRefreshDelegate
extension AlternativeViewController: PullToRefreshDelegate {
    func beginRefreshing() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          self.pullToRefresh.endRefreshing()
        }
    }
}
