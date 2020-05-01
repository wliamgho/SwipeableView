//
//  HomeViewController.swift
//  SwipeableView
//
//  Created by William on 21/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  @IBOutlet weak var containerCardView: UIView!
  //  @IBOutlet weak var swipeableCardView: SwipeableCardView!
  private let data = ["test 1", "test 2", "test 3", "test 4"]

  private let collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewFlowLayout())
    return collectionView
  }()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

//    swipeableCardView.updateData = ["test 1", "test 2", "test 3", "test 4", "test 5", "test 6", "test 7"]

    addChildVC()
  }

  private func addChildVC() {
    collectionView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: self.containerCardView.frame.width,
                                  height: self.containerCardView.frame.height)
    let swipeableCardController = SwipeableCardController(dataSource: data,
                                                          collectionViewLayout: collectionView.collectionViewLayout)
    addChild(swipeableCardController)

    swipeableCardController.didMove(toParent: self)
    swipeableCardController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    swipeableCardController.view.frame = self.containerCardView.bounds
    containerCardView.addSubview(swipeableCardController.view)
  }
}
