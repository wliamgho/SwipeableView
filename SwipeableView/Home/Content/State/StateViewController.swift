//
//  StateViewController.swift
//  SwipeableView
//
//  Created by William on 22/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class StateViewController: UIViewController {
    @IBOutlet weak var cardView: CardView!

    var status = ""
    var currentPage = 0

    init(status: String, currentPage: Int) {
        self.status = status
        self.currentPage = currentPage

        super.init(nibName: "StateViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        cardView.statusLabel.text = status
        cardView.layer.borderWidth = 0
    }
}

extension StateViewController: PagedStreamView {
    func getCurrentPage() -> Int {
        return currentPage
    }

    func setPage(_ page: Int) {
        currentPage = page
    }
}
