//
//  FooterView.swift
//  SwipeableView
//
//  Created by William on 02/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class FooterView: UICollectionReusableView {
  @IBOutlet weak var moreButton: UIButton!

  static func reuseIdentifier() -> String {
    return String(describing: self)
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    moreButton.layer.cornerRadius = 16
    moreButton.layer.borderWidth = 1
    moreButton.layer.borderColor = UIColor.systemBlue.cgColor
  }
}
