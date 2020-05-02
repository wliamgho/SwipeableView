//
//  CustomPageViewController.swift
//  SwipeableView
//
//  Created by William on 01/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

protocol CustomPageViewDelegate: class {
  func setCurrentPage(index: Int)
}

class CustomPageViewController: SwipeableCollectionController, UICollectionViewDelegateFlowLayout {
  weak var delegate: CustomPageViewDelegate?

  var dataSource = [String]() {
    didSet {
      collectionView.reloadData()
    }
  }
  
  init() {
    super.init(nibName: "CustomPageViewController", bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.collectionView.register(UINib(nibName: PageItemCell.reuseIdentifier(), bundle: nil),
                                 forCellWithReuseIdentifier: PageItemCell.reuseIdentifier())

  }

  override func calculateSectionInset() -> CGFloat {
    return 20
  }

  override func getIndexOfItem(index: Int) {
    delegate?.setCurrentPage(index: index)
  }

  // MARK: UICollectionViewDataSource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageItemCell.reuseIdentifier(), for: indexPath) as! PageItemCell
    cell.cardView.statusLabel.text = dataSource[indexPath.row]
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width - 40, height: 200)
  }
}
