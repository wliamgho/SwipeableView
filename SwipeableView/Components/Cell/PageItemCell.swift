//
//  PageItemCell.swift
//  SwipeableView
//
//  Created by William on 26/04/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class PageItemCell: UICollectionViewCell {
  @IBOutlet weak var cardView: CardView!

  static func reuseIdentifier() -> String {
    return String(describing: self)
  }

  static func getSize() -> CGSize {
    return CGSize(width: 336, height: 180)
  }

  override func awakeFromNib() {
    super.awakeFromNib()

  }
}
