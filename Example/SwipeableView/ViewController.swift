//
//  ViewController.swift
//  SwipeableView
//
//  Created by William on 03/10/2020.
//  Copyright (c) 2020 William. All rights reserved.
//

import UIKit
import SwipeableView

class ViewController: UIViewController {
  private var cardView: CardView!

  override func viewDidLoad() {
    super.viewDidLoad()

    loadUI()
  }

  private func loadUI() {
    loadCardView()
  }

  private func loadCardView() {
    cardView = CardView(title: "Welcome")
    self.view.addSubview(cardView)

    cardView.translatesAutoresizingMaskIntoConstraints = false

    cardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
    cardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
    cardView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 24).isActive = true
    cardView.heightAnchor.constraint(equalToConstant: 200).isActive = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

