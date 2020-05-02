//
//  ArticleCollectionListView.swift
//  SwipeableView
//
//  Created by William on 02/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class ArticleCollectionListView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
    self.register(UINib(nibName: ArticleItemCell.reuseIdentifier(), bundle: nil),
                  forCellWithReuseIdentifier: ArticleItemCell.reuseIdentifier())
    self.register(UINib(nibName: FooterView.reuseIdentifier(), bundle: nil),
                  forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                  withReuseIdentifier: FooterView.reuseIdentifier())

    self.delegate = self
    self.dataSource = self
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleItemCell.reuseIdentifier(), for: indexPath) as! ArticleItemCell
    cell.titleLabel.text = data[indexPath.row]
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterView.reuseIdentifier(), for: indexPath) as! FooterView
    
    return footer
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (collectionView.frame.width - 50) / 2, height: 240)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    return CGSize(width: 145, height: 80)
  }
}
