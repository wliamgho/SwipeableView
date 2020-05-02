//
//  CategoryViewCell.swift
//  SwipeableView
//
//  Created by William on 02/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var titleLabel: UILabel!

  override var isSelected: Bool {
    didSet {
      self.containerView.backgroundColor = isSelected ? .black : .clear
      self.titleLabel.textColor = isSelected ? .white : .black
    }
  }

  static func size(text: String) -> CGSize {
    let label = UILabel(frame: .zero)
    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    label.text = text
    label.sizeToFit()
    return CGSize(width: label.frame.width + 40, height: 28)
  }
  
  static func reuseIdentifier() -> String {
    return String(describing: self)
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    containerView.layer.borderWidth = 1
    containerView.layer.masksToBounds = false
    containerView.layer.cornerRadius = 14
  }
}
