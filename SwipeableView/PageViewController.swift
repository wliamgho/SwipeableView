//
//  PageViewController.swift
//  SwipeableView
//
//  Created by William on 24/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

protocol PageViewDelegate: class {
    func pageViewDidSwap()
}

class PageViewController: UIPageViewController {
    weak var pageDelegate: PageViewDelegate?

    private(set) var listData = [String]()
    private(set) var currentIndex = 0

    var controller: PagedStreamView!

    // MARK: - Initialize
    init(listData: [String]) {
        self.listData = listData

        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        if let startingVC = setViewController(withIndex: 0) as? UIViewController {
            self.setViewControllers([startingVC], direction: .forward, animated: true, completion: nil)
        }
    }

    private func setViewController(withIndex index: Int) -> PagedStreamView? {
        if self.listData.count == 0 || index >= self.listData.count { return nil }

        let status = listData[index]

        if listData[index] == "List" {
            controller = ListViewController(currentPage: index)
        } else {
            controller = ScreenViewController(status: status, currentPage: index)
        }

        currentIndex = index

        return controller
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PagedStreamView).currentPage

        if index == 0 || index == NSNotFound {
            return nil
        }

        index -= 1

        return setViewController(withIndex: index) as? UIViewController
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PagedStreamView).currentPage

        if index == NSNotFound { return nil }

        index += 1

        if index == self.listData.count { return nil }

        return setViewController(withIndex: index) as? UIViewController
    }

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let vc = pendingViewControllers[0] as? PagedStreamView {
            self.currentIndex = vc.currentPage
            pageDelegate?.pageViewDidSwap()
        }
    }
}
