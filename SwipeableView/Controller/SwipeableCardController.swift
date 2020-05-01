//
//  SwipeableCardController.swift
//  SwipeableView
//
//  Created by William on 27/04/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class SwipeableCardController: UICollectionViewController {
  private var indexOfCellBeforeDragging = 0

  var dataSource: [String]
  let layout: UICollectionViewLayout

  private var collectionViewFlowLayout: UICollectionViewFlowLayout {
    return layout as! UICollectionViewFlowLayout
  }

  // MARK: - Initialize
  init(dataSource: [String], collectionViewLayout layout: UICollectionViewLayout) {
    self.dataSource = dataSource
    self.layout = layout

    super.init(collectionViewLayout: layout)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .clear
    self.collectionView.backgroundColor = .clear

    collectionViewFlowLayout.minimumLineSpacing = 0
    collectionViewFlowLayout.scrollDirection = .horizontal

    collectionView.register(UINib(nibName: CardViewCell.reuseIdentifier(), bundle: nil),
                  forCellWithReuseIdentifier: CardViewCell.reuseIdentifier())
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    configureCollectionViewLayoutItemSize()
  }

  private func configureCollectionViewLayoutItemSize() {
    let inset: CGFloat = 0
    let frameSize = collectionViewFlowLayout.collectionView!.frame.size

    collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    collectionViewFlowLayout.itemSize = CGSize(width: (frameSize.width - inset * 2),
                                               height: frameSize.height)
  }

  private func indexOfMajorCell() -> Int {
    let itemWidth = collectionViewFlowLayout.itemSize.width
    let proportionalOffset = collectionViewLayout.collectionView!.contentOffset.x / itemWidth
    let index = Int(round(proportionalOffset))
    let numberOfItems = collectionView.numberOfItems(inSection: 0)
    let safeIndex = max(0, min(numberOfItems - 1, index))
    return safeIndex
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return dataSource.count
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CardViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewCell.reuseIdentifier(),
                                                                for: indexPath) as! CardViewCell
    cell.cardView.statusLabel.text = dataSource[indexPath.row]
    return cell
  }

  override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    indexOfCellBeforeDragging = indexOfMajorCell()
  }

  override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
      // Stop scrollView sliding:
      targetContentOffset.pointee = scrollView.contentOffset

      // calculate where scrollView should snap to:
      let indexOfMajorCell = self.indexOfMajorCell()

      // calculate conditions:
      let dataSourceCount = collectionView(collectionView!, numberOfItemsInSection: 0)
      let swipeVelocityThreshold: CGFloat = 0.5 // after some trail and error
      let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < dataSourceCount && velocity.x > swipeVelocityThreshold
      let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
      let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
      let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)

      if didUseSwipeToSkipCell {

          let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
          let toValue = collectionViewFlowLayout.itemSize.width * CGFloat(snapToIndex)

          print("toValue", toValue)
          // Damping equal 1 => no oscillations => decay animation:
          UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
              scrollView.contentOffset = CGPoint(x: toValue, y: 0)
              scrollView.layoutIfNeeded()
          }, completion: nil)

      } else {
          // This is a much better way to scroll to a cell:
          let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
          collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      }
  }
}
