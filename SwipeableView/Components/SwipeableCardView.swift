//
//  SwipeableCardView.swift
//  SwipeableView
//
//  Created by William on 26/04/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class SwipeableCardView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  private var data = [String]()
  private var nextPage = 0
  private var prevIndex = 0
  private var spacing: CGFloat = 20

  private var collectionViewFlowLayout = UICollectionViewFlowLayout()

  var updateData: [String]? {
    didSet {
      didSetDataSource()
    }
  }

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    self.collectionViewFlowLayout = layout as! UICollectionViewFlowLayout
    configureLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    configureLayout()
  }

  private func configureLayout() {
    self.register(UINib(nibName: PageItemCell.reuseIdentifier(), bundle: nil),
                  forCellWithReuseIdentifier: PageItemCell.reuseIdentifier())
    self.delegate = self
    self.dataSource = self
  }

  private func didSetDataSource() {
    guard let updateData = updateData else { return }
    self.data = updateData
    self.reloadData()
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: PageItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: PageItemCell.reuseIdentifier(), for: indexPath) as! PageItemCell
    cell.cardView.statusLabel.text = data[indexPath.row]
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return PageItemCell.getSize()
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    let pageWidth = (PageItemCell.getSize().width + spacing)
    prevIndex = (Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth)) + 1)
  }

  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    // 1
    let pageWidth = (PageItemCell.getSize().width + spacing)
    let maxPage = Int(ceil(scrollView.contentSize.width / pageWidth)) - 1
    var newPage = prevIndex

    if velocity.x == 0.0 {
      newPage = Int(floor((targetContentOffset.pointee.x - pageWidth / 2) / pageWidth)) + 1
    } else {
      newPage = velocity.x > 0.0 ? prevIndex + 1 : prevIndex - 1

      if newPage < 0 {
        newPage = 0
      }

      if newPage > Int(ceil(scrollView.contentSize.width / pageWidth)) {
        newPage = Int(ceil((pageWidth + spacing) / pageWidth)) - 1
      }
    }

    if newPage == maxPage {
      targetContentOffset.pointee.x = scrollView.contentSize.width - UIScreen.main.bounds.size.width
    } else {
      targetContentOffset.pointee.x = CGFloat(newPage) * pageWidth
    }

    self.nextPage = newPage
  }
}
