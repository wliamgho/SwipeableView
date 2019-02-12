//
//  ParentViewController.swift
//  SwipeableView
//
//  Created by William on 12/02/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {
    @IBOutlet weak var menuBar: MenuBar!
    fileprivate(set) var viewPager = UIPageViewController(transitionStyle: .scroll,
                                                          navigationOrientation: .horizontal,
                                                          options: nil)

    fileprivate var tabIndex: TabIndex

    var page = ["Alpha", "Beta"]
    var currentTab = 0

    init(withTabIndex tabIndex: TabIndex) {
        self.tabIndex = tabIndex

        super.init(nibName: String(describing: ParentViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        menuBar.layer.borderWidth = 1
        menuBar.layer.borderColor = UIColor.lightGray.cgColor

        // Set menu item
        for item in page {
            menuBar.buttonTitle = item
        }

        menuBar.delegate = self

        // Set pager frame
        var framePager = view.frame
        framePager.origin.y = menuBar.frame.maxY
        framePager.size.height = self.view.frame.height - menuBar.frame.maxY

        addChild(viewPager)
        viewPager.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewPager.view.frame = framePager

        view.addSubview(viewPager.view)

        viewPager.setViewControllers([viewController(atIndex: 0)!],
                                     direction: .forward,
                                     animated: true,
                                     completion: nil)

        viewPager.didMove(toParent: self)

        viewPager.delegate = self
        viewPager.dataSource = self
    }

    private func viewController(atIndex index: Int) -> UIViewController? {
        if currentTab == 0 {
            let alphaVC = AlphaViewController()

            return alphaVC
        } else {
            let betaVC = BetaViewController()

            return betaVC
        }
    }
}

extension ParentViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let beforeIndex = currentTab - 1

        if beforeIndex < 0 {
            return nil
        }

        currentTab = beforeIndex
        menuBar.indicatorActive = currentTab
        debugPrint("beforeIndex: \(beforeIndex)")

        return self.viewController(atIndex: currentTab)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let nextIndex = currentTab + 1

        if nextIndex >= page.count {
            return nil
        }

        currentTab = nextIndex
        menuBar.indicatorActive = currentTab

        debugPrint("nextIndex: \(nextIndex)")

        return self.viewController(atIndex: currentTab)
    }
}

extension ParentViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed {
            menuBar.indicatorActive = currentTab
        }
    }
}

extension ParentViewController: MenuBarDelegate {
    func menuItemDidTouch(withIndex index: Int) {
        if index != currentTab {
            if index > currentTab {
                self.currentTab = index
                self.viewPager.setViewControllers([self.viewController(atIndex: self.currentTab)!], direction: .forward, animated: true, completion: nil)
            } else {
                self.currentTab = index
                self.viewPager.setViewControllers([self.viewController(atIndex: self.currentTab)!], direction: .reverse, animated: true, completion: nil)
            }
        } else {
            self.currentTab = index
        }
    }
}
