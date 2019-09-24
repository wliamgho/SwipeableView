//
//  ListViewController.swift
//  SwipeableView
//
//  Created by William on 21/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, PagedStreamView {
    var currentPage: Int = 0

    @IBOutlet weak var cardView: CardView!

    var status = ""

    init(status: String, currentPage: Int = 0) {
        self.status = status
        self.currentPage = currentPage

        super.init(nibName: "ListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardView.statusLabel.text = status
    }
}
