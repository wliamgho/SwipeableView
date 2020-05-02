//
//  SwipeableContentView.swift
//  SwipeableView
//
//  Created by William on 01/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class SwipeableContentView: UIView {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var tableView: UITableView!

  var contentData = [String]() {
    didSet {
      self.tableView.reloadData()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    loadNib()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    loadNib()
  }

  private func loadNib() {
    Bundle.main.loadNibNamed("SwipeableContentView", owner: self, options: nil)

    guard let content = contentView else { return }
    content.frame = self.bounds
    content.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    self.addSubview(content)

    tableView.register(UINib(nibName: ContentViewCell.reuseIdentifier(), bundle: nil),
                       forCellReuseIdentifier: ContentViewCell.reuseIdentifier())
  }
}

extension SwipeableContentView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contentData.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ContentViewCell.reuseIdentifier(), for: indexPath) as! ContentViewCell
    cell.titleLabel.text = contentData[indexPath.row]
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }

  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
