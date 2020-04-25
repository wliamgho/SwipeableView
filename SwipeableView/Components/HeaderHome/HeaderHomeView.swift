//
//  HeaderHomeView.swift
//  SwipeableView
//
//  Created by William on 25/04/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class HeaderHomeView: UIView {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var nameLabel: UILabel!

  @IBInspectable var fullname: String = "" {
    didSet {
      self.nameLabel.text?.append(fullname)
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    loadNib()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    loadNib()
  }

  private func loadNib() {
    Bundle.main.loadNibNamed("HeaderHomeView", owner: self, options: nil)

    guard let content = contentView else { return }
    content.frame = self.bounds
    content.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    self.addSubview(content)
  }
}
