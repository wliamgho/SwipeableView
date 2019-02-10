//
//  ItemCell.swift
//  SwipeableView
//
//  Created by William on 09/02/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var indicatorView: UIView!

    var title = "" {
        didSet {
            didSetItemTitle()
        }
    }

    static func reuseIdentifier() -> String {
        return "ItemCell"
    }

    static func getSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width / 2, height: 48)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        // Top corner radius
        let radiusSize = CGSize(width: 2, height: 0)
        let path = UIBezierPath(roundedRect: indicatorView.bounds,
                                byRoundingCorners: [.topRight, .topLeft], cornerRadii: radiusSize)

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath

        indicatorView.layer.mask = maskLayer

        itemLabel.textAlignment = .center
    }

    private func didSetItemTitle() {
        itemLabel.text = title
    }
}
