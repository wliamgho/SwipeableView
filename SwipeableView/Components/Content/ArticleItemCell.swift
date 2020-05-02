//
//  ArticleItemCell.swift
//  SwipeableView
//
//  Created by William on 02/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class ArticleItemCell: UICollectionViewCell {
  @IBOutlet weak var cardView: CardView!
  @IBOutlet weak var imageView: UIView!
  @IBOutlet weak var titleLabel: UILabel!

  static func reuseIdentifier() -> String {
    return String(describing: self)
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 6
    imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right - Top left
  }
}
