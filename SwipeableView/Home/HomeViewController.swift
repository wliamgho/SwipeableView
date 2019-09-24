//
//  HomeViewController.swift
//  SwipeableView
//
//  Created by William on 21/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

protocol PageViewControllerDelegate: class {
    func pageViewController(pageVC: UIViewController, didUpdatePageCount count: Int)

    func pageViewController(pageVC: UIViewController, didUpdatePageIndex index: Int)
}

class HomeViewController: UIViewController {
    weak var delegate: PageViewControllerDelegate?

    @IBOutlet weak var headerView: UIView!

    var currentStreamVC = [UIViewController]()
    var pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal,
                                                  options: nil)

    var listData: [String] = [String]()
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

        getStatus()

        pageViewController.didMove(toParent: self)
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let startingVC = setViewControllers(index: 0) as? UIViewController {
            pageViewController.setViewControllers([startingVC], direction: .forward, animated: true, completion: nil)
        }
    }

    private func configurePageView() {
        var viewPagerFrame = view.frame
        viewPagerFrame.origin.y = headerView.frame.height - 50
        viewPagerFrame.size.height = self.view.frame.height

        addChild(pageViewController)

        pageViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pageViewController.view.frame = viewPagerFrame

        view.addSubview(pageViewController.view)
    }

//    private func setViewControllers(withStatus status: String) -> UIViewController {
//        if status == "on_processed" || status == "payment_status" || status == "delivered" {
//            let status = StatusViewController(status: status)
//            return status
//        } else if status == "completed" {
//            let list = ListViewController(status: status)
//            return list
//        } else {
//            let state = StateViewController(status: status)
//            return state
//        }
//     }
    private func setViewControllers(index: Int) -> PagedStreamView? {
        if self.listData.count == 0 || index >= self.listData.count { return nil }

        let status = listData[index]
        let controller: PagedStreamView

        if status == "on_processed" || status == "payment_status" || status == "delivered" {
            controller = StatusViewController(status: status, currentPage: index)
        } else if status == "completed" {
            controller = ListViewController(status: status, currentPage: index)
        } else {
            controller = StateViewController(status: status, currentPage: index)
        }

        currentIndex = index

        return controller
    }

    // Load status json file
    private func getStatus() {
        if let path = Bundle.main.path(forResource: "Status", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let statusOrder = try JSONDecoder().decode([StatusModel].self, from: data)

                for order in statusOrder {
                    listData.append(order.status)

                    // if order status == "completed", get List
                }
            } catch {
                debugPrint("ERROR to read json file", error.localizedDescription)
            }
        }
    }

    private func getList() {
      // Load json file
      if let path = Bundle.main.path(forResource: "List", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: [])
          } catch {
              debugPrint("ERROR to read json file", error.localizedDescription)
          }
      }
    }
}

extension HomeViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PagedStreamView).currentPage

        if index == 0 || index == NSNotFound {
            return nil
        }

        index -= 1

        return setViewControllers(index: index) as! UIViewController
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PagedStreamView).currentPage

        if index == NSNotFound { return nil }

        index += 1

        if index == self.listData.count { return nil }

        return setViewControllers(index: index) as! UIViewController
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.listData.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
