//
//  CardView.swift
//  SwipeableView
//
//  Created by William on 21/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class CardView: UIView {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var statusLabel: UILabel!

  let containerView = UIView()
  private var shadowLayer: CAShapeLayer!

  override init(frame: CGRect) {
    super.init(frame: frame)

    loadNib()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)

    loadNib()
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    if shadowLayer == nil {
        shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor

        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0, height: 2.0)
        shadowLayer.shadowOpacity = 0.8
        shadowLayer.shadowRadius = 2

        layer.insertSublayer(shadowLayer, at: 0)
    }
  }

  private func loadNib() {
    Bundle.main.loadNibNamed("CardView", owner: self, options: nil)

    guard let content = contentView else { return }
    content.frame = self.bounds
    content.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    addSubview(content)

    configureLayout()
  }

  private func configureLayout() {
    containerView.layer.cornerRadius = 16
    containerView.layer.masksToBounds = true

    addSubview(containerView)

    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
}
