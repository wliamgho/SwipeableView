//
//  ArticleListView.swift
//  SwipeableView
//
//  Created by William on 02/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class ArticleListView: UIView {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var categoryCollectionView: ArticleCategoryView!
  @IBOutlet weak var articleCollectionListView: ArticleCollectionListView!

  override init(frame: CGRect) {
    super.init(frame: frame)

    loadNib()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)

    loadNib()
  }

  private func loadNib() {
    Bundle.main.loadNibNamed("ArticleListView", owner: self, options: nil)

    guard let content = contentView else { return }
    content.frame = self.bounds
    content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(content)

    categoryCollectionView.data = ["Now", "Highlighted", "Recommendation", "Category 1", "Category 2", "Category 3"]
    articleCollectionListView.data = ["Moka Remains an Open Platform Post Gojek Acquisition",
                                      "Shooper App to Facilitate Users Comparing Prices from Various Stores",
                                      "Tokopedia Releases Live Shopping Feature Tokopedia Play",
                                      "Prixa Expands Digital Health Service, Targeting  B2B and B2G",
                                      "Helicap Fintech Secures Over 155 Billion Rupiah Funding from Saison Capital",
                                      "Qoala Insurtech Platform Bags 209 Billion Rupiah Series A Funding"]
  }
}
