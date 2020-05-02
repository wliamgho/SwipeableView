//
//  ArticleContentView.swift
//  SwipeableView
//
//  Created by William on 02/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class ArticleContentView: UIView {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var categoryCollectionView: ArticleCategoryView!

  override init(frame: CGRect) {
    super.init(frame: frame)

    loadNib()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)

    loadNib()
  }

  private func loadNib() {
    Bundle.main.loadNibNamed("ArticleContentView", owner: self, options: nil)

    guard let content = contentView else { return }
    content.frame = self.bounds
    content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(content)

    categoryCollectionView.data = ["Now", "Highlighted", "Recommendation", "Category 1", "Category 2", "Category 3"]
  }
}
