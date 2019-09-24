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
    private var pageViewController: PageViewController!
    var listData: [String] = [String]()

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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        for status in listData {
            pageViewController = PageViewController(status: status)
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

    private func setViewControllers(withStatus status: String) -> UIViewController {
        if status == "on_processed" || status == "payment_status" || status == "delivered" {
            let status = StatusViewController(status: status)
            return status
        } else if status == "completed" {
            let list = ListViewController(status: status)
            return list
        } else {
            let state = StateViewController(status: status)
            return state
        }
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
        let previousIndex = currentPage - 1
        let index = self.currentStreamVC.index(of: viewController)

        if index == 0 {
            return nil
        }

        currentPage = previousIndex

        return setViewControllers(withStatus: listData[previousIndex])
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = self.currentStreamVC.index(of: viewController)
        let nextIndex = currentPage + 1

        if index == currentStreamVC.count - 1 {
            return nil
        }

        currentPage = currentPage + 1
        return setViewControllers(withStatus: listData[nextIndex])
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentView = pageViewController.viewControllers?.first as! UIViewController
        debugPrint("current view", currentView)
    }
}
