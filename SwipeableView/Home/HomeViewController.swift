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

    var pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal,
                                                  options: nil)
    var listData: [String] = [String]()
    var currentStreamVC = UIViewController()
    var currentPage = 0
    var nextPage = 0

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

        for (index, status) in listData.enumerated() {
            currentStreamVC = setViewControllers(withStatus: status, index: index)
        }

        pageViewController.setViewControllers([currentStreamVC],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
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

    private func setViewControllers(withStatus status: String, index: Int) -> UIViewController {
        debugPrint("status", status)
        switch status {
        case "on_processed", "payment_status", "delivered":
            let status = StatusViewController(status: status, currentPage: index)
            return status
        case "completed":
            let list = ListViewController(status: status, currentPage: index)
            return list
        case "created", "waiting_for_payment":
            let state = StateViewController(status: status, currentPage: index)
            return state
        default:
            return UIViewController()
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

        if previousIndex < 0 {
            return nil
        }

        currentPage = previousIndex
        debugPrint("BEFORE", previousIndex)

        return setViewControllers(withStatus: listData[previousIndex], index: previousIndex)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let nextIndex = currentPage + 1
        if nextIndex >= listData.count {
            return nil
        }
        currentPage = nextIndex

        debugPrint("nextIndex", nextIndex)
        return setViewControllers(withStatus: listData[nextIndex], index: nextIndex)
    }

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
//        if let pendingVC = pendingViewControllers.first as? PagedStreamView {
//            nextPage = pendingVC.currentPage
//        }

        debugPrint("Will transition \(currentPage) NEXT \(nextPage)")
    }
}
