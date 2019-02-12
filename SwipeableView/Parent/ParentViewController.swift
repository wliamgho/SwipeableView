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

        let indexPath = IndexPath(item: 0, section: 0)
        
        // Set tab item
        menuBar.data = page
        
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)

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

        if beforeIndex >= 0 {
            return nil
        }

        currentTab = beforeIndex
        debugPrint("beforeIndex: \(beforeIndex)")

        return self.viewController(atIndex: currentTab)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let nextIndex = currentTab + 1

        if nextIndex >= page.count {
            return nil
        }

        currentTab = nextIndex

        debugPrint("nextIndex: \(nextIndex)")

        return self.viewController(atIndex: currentTab)
    }
}

extension ParentViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController]) {
    }
}
