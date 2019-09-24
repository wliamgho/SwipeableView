//
//  PageViewController.swift
//  SwipeableView
//
//  Created by William on 24/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    var currentIndex: Int {
        get {
            return orderedViewControllers.index(of: orderedViewControllers.first!)!
        }
        set {
            guard newValue >= 0, newValue < orderedViewControllers.count else { return }

            let vc = orderedViewControllers[newValue]
            let direction: UIPageViewController.NavigationDirection = newValue > currentIndex ? .forward : .reverse
            self.setViewControllers([vc], direction: direction, animated: true, completion: nil)
        }
    }

    private(set) var orderedViewControllers: [UIViewController] = [UIViewController]()
    private(set) var status = ""

    // MARK: - Initialize
    init(status: String) {
        self.status = status

        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setOrderedViewController()
    }

    private func setOrderedViewController() {
        var controller = UIViewController()

        if status == "on_processed" || status == "payment_status" || status == "delivered" {
            controller = StatusViewController(status: status)
        }

        if status == "completed" {
            controller = ListViewController(status: status)
        } else {
            controller = StateViewController(status: status)
        }

        orderedViewControllers.append(controller)

        if let firstVC = orderedViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let previousIndex = currentIndex - 1

        guard previousIndex >= 0 else { return nil }

        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let nextIndex = currentIndex + 1

        guard nextIndex < orderedViewControllers.count else { return nil }

        return orderedViewControllers[nextIndex]
    }
}
