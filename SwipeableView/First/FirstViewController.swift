//
//  FirstViewController.swift
//  SwipeableView
//
//  Created by William on 09/02/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var menuBar: MenuBar!

    var currentIndex: Int = 0
    var tabs = ["First Tab", "Second Tab"]
    fileprivate(set) var pageController: UIPageViewController!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
  
        let indexPath = IndexPath(item: 0, section: 0)

        // Set tab item
        menuBar.data = tabs

        // Set page controller
        presentPageController()

        pageController.delegate = self
        pageController.dataSource = self

        // Set selected menu bar
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
        pageController.setViewControllers([viewController(atIndex: 0)!], direction: .forward, animated: true, completion: nil)
    }

    // Present PageController
    private func presentPageController() {
        self.pageController = UIPageViewController()
        self.pageController.view.frame = CGRect(x: 0,
                                                 y: menuBar.frame.maxY,
                                                 width: self.view.frame.width,
                                                 height: self.view.frame.height - menuBar.frame.maxY)
        self.addChild(self.pageController)
        self.view.addSubview(self.pageController.view)

        self.pageController.didMove(toParent: self)
    }

    // Present View controller by index
    private func viewController(atIndex index: Int) -> UIViewController? {
        if self.menuBar.data.count == 0 || index >= self.menuBar.data.count {
            return nil
        }

        let secondVC = SecondViewController()
        secondVC.index = index

        currentIndex = index
        return secondVC
    }
}

// MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource
extension FirstViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! SecondViewController).index

        if index == 0 || index == NSNotFound {
            return nil
        }

        index -= 1
        return self.viewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! SecondViewController).index

        if index == tabs.count || index == NSNotFound {
            return nil
        }

        index += 1
        return self.viewController(atIndex: index)
    }
}
