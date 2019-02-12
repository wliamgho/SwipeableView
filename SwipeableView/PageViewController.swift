//
//  PageViewController.swift
//  SwipeableView
//
//  Created by William on 12/02/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    @IBOutlet weak var menuBar: MenuBar!

    var tabs = ["First Tab", "Second Tab"]
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let indexPath = IndexPath(item: 0, section: 0)
//        
//        // Set tab item
//        menuBar.data = tabs
//
//        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
        self.setViewControllers([viewController(atIndex: 0)!], direction: .forward, animated: true, completion: nil)

        self.delegate = self
        self.dataSource = self
    }

    // Present View controller by index
    private func viewController(atIndex index: Int) -> UIViewController? {
        if self.menuBar.data.count == 0 || index >= self.menuBar.data.count {
            return nil
        }
        
        let secondVC = SecondViewController()
        secondVC.index = index
        
        self.index = index
        return secondVC
    }

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
