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
  private var swipeableController: CustomPageViewController!
  private var swipeableContentView: SwipeableContentView!

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
    if let swipeContent = setSwipeableContentView() as? UIView {
      stackView.addArrangedSubview(swipeContent)
    }
  }

  private func setSwipeableContentView() -> UIView? {
    swipeableContentView = SwipeableContentView()
    let data = ["ABC", "DFG", "HIJ", "KLM", "NOP", "QRS", "TUV", "WXYZ"]
    let items: CGFloat = CGFloat(data.count)
    let eachItemHeight: CGFloat = 200
    let estimatedHeight: CGFloat = items * eachItemHeight
    swipeableContentView = SwipeableContentView()
    swipeableContentView.contentData = data
    swipeableContentView.heightAnchor.constraint(equalToConstant: estimatedHeight).isActive = true
    swipeableContentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    return swipeableContentView
  }

  private func addChild() {
    let swipeableContainer = UIView(frame: .zero)
    swipeableContainer.heightAnchor.constraint(equalToConstant: 200).isActive = true
    swipeableContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    swipeableController = CustomPageViewController()
    swipeableController.dataSource = ["Test 1", "Test 2", "Test 3", "Test 4", "Test 5"]
    self.addChild(swipeableController)

    swipeableController.didMove(toParent: self)
    swipeableController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    swipeableController.view.frame = swipeableContainer.bounds
    swipeableContainer.addSubview(swipeableController.view)

    swipeableContainer.backgroundColor = .clear
    stackView.addArrangedSubview(swipeableContainer)
  }
}
