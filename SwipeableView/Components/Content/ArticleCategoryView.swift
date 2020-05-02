//
//  ArticleCategoryView.swift
//  SwipeableView
//
//  Created by William on 02/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class ArticleCategoryView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  var data = [String]() {
    didSet {
      self.reloadData()
    }
  }

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)

    configureLayout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)

    configureLayout()
  }

  private func configureLayout() {
    self.register(UINib(nibName: CategoryViewCell.reuseIdentifier(), bundle: nil),
                  forCellWithReuseIdentifier: CategoryViewCell.reuseIdentifier())
    self.delegate = self
    self.dataSource = self
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryViewCell.reuseIdentifier(), for: indexPath) as! CategoryViewCell
    cell.titleLabel.text = data[indexPath.row]
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CategoryViewCell.size(text: data[indexPath.row])
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  }
}
