//
//  HomeViewController.swift
//  SwipeableView
//
//  Created by William on 21/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var stackView: UIStackView!

  private var headerHomeView: HeaderHomeView!
  private var pageViewController: CustomPageViewController!
  private var swipeableContentView: SwipeableContentView!

  private var swipeableHeightConstraint: NSLayoutConstraint!

  let mockData = [["ABC"], ["HIJ", "KLM"], ["NOP"], ["QRS", "TUV", "WXYZ", "DFG", "QWERTY", "ASDFA"]]

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    addStackViewLayout()
  }

  // MARK: - Private method
  private func addStackViewLayout() {
    // Add header home view
    headerHomeView = HeaderHomeView(frame: .zero)
    headerHomeView.fullname = "Jacky"
    stackView.addArrangedSubview(headerHomeView)

    // Add swipeable controller view
    addChild()

    // Add swipeable content
    stackView.addArrangedSubview(setSwipeableContentView())

    // Add article content
    stackView.addArrangedSubview(setArticleContentView())
  }

  private func setSwipeableContentView() -> UIView {
    let estimatedHeight = CGFloat(mockData[0].count * 200)
    swipeableContentView = SwipeableContentView()
    swipeableContentView.translatesAutoresizingMaskIntoConstraints = false
    swipeableHeightConstraint = NSLayoutConstraint(item: swipeableContentView,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1, constant: estimatedHeight)
    swipeableContentView.addConstraint(swipeableHeightConstraint)
    swipeableContentView.layoutIfNeeded()
    return swipeableContentView
  }

  private func updateContentHeight(item: Int) {
    let estimatedHeight = CGFloat(item * 200)
    DispatchQueue.main.async {[weak self] in
      self?.swipeableHeightConstraint.constant = estimatedHeight
    }
  }

  private func setArticleContentView() -> UIView {
    return ArticleContentView(frame: .zero)
  }

  private func addChild() {
    let containerView = UIView(frame: .zero)
    containerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    pageViewController = CustomPageViewController()
    pageViewController.delegate = self
    pageViewController.dataSource = ["Test 1", "Test 2", "Test 3", "Test 4"]
    self.addChild(pageViewController)

    pageViewController.didMove(toParent: self)
    pageViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    pageViewController.view.frame = containerView.bounds
    containerView.addSubview(pageViewController.view)

    containerView.backgroundColor = .clear
    stackView.addArrangedSubview(containerView)
  }
}

extension HomeViewController: CustomPageViewDelegate {
  func setCurrentPage(index: Int) {
    let item = mockData[index]

    self.updateContentHeight(item: item.count)
    swipeableContentView.contentData = item
  }
}
