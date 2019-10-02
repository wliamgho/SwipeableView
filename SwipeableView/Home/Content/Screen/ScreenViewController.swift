//
//  ScreenViewController.swift
//  SwipeableView
//
//  Created by William on 22/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class ScreenViewController: UIViewController, PagedStreamView {
    @IBOutlet weak var cardView: CardView!

    var status = ""
    var currentPage: Int = 0

    init(status: String, currentPage: Int = 0) {
        self.status = status
        self.currentPage = currentPage

        super.init(nibName: "ScreenViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        cardView.statusLabel.text = status
        cardView.layer.borderWidth = 0
    }
}
