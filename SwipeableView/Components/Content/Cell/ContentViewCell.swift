//
//  ContentViewCell.swift
//  SwipeableView
//
//  Created by William on 01/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class ContentViewCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!

  static func reuseIdentifier() -> String {
    return String(describing: self)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
      // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
    
}
