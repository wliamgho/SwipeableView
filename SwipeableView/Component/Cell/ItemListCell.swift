//
//  ItemListCell.swift
//  SwipeableView
//
//  Created by William on 05/11/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class ItemListCell: UICollectionViewCell {
    @IBOutlet weak var itemLabel: UILabel!

    static func reuseIdentifier() -> String {
        return String(describing: self)
    }

    static func size() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width,
                      height: 250)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
