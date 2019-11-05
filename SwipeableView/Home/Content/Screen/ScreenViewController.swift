//
//  ScreenViewController.swift
//  SwipeableView
//
//  Created by William on 22/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class ScreenViewController: UIViewController, PagedStreamView {
    var currentView: UIView {
        return self.view
    }

    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!

    var status = ""
    var currentPage: Int = 0

    var itemData = ["test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test"]

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

        tableView.register(UINib(nibName: TableViewCell.reuseId(), bundle: nil),
                           forCellReuseIdentifier: TableViewCell.reuseId())
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension ScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId(), for: indexPath) as! TableViewCell
        cell.itemLabel.text = "\(itemData[indexPath.row]) \(indexPath.row)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
