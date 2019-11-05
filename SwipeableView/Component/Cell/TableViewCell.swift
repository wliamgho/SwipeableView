//
//  TableViewCell.swift
//  SwipeableView
//
//  Created by William on 05/11/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!

    static func reuseId () -> String {
        return String(describing: self)
    }

    static func size() -> CGFloat {
        return 200
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
