//
//  TestView.swift
//  SwipeableView_Example
//
//  Created by William on 10/03/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class TestView: UIView {
  var contentView = UIView()
  var titleLabel = UILabel()
  var containerView = UIView()

  private var shadowLayer: CAShapeLayer!

  override init(frame: CGRect) {
    super.init(frame: frame)

    loadView()
  }

  init() {
    super.init(frame: CGRect(x: 0,
                             y: 20,
                             width: UIScreen.main.bounds.width,
                             height: 200))

    loadView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)

    loadView()
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

      contentView.layer.insertSublayer(shadowLayer, at: 0)
    }
  }

  private func setTitleLabel() {
    titleLabel.text = "Test"
    titleLabel.numberOfLines = 0
    titleLabel.frame = CGRect(x: self.center.x,
                              y: self.bounds.size.height / 2,
                              width: self.bounds.size.width,
                              height: self.bounds.size.height / 2)
    titleLabel.textAlignment = .center
    titleLabel.sizeToFit()
    self.contentView.addSubview(titleLabel)

    let centerX = NSLayoutConstraint(item: titleLabel,
                                     attribute: NSLayoutAttribute.centerX,
                                     relatedBy: NSLayoutRelation.equal,
                                     toItem: self.contentView,
                                     attribute: NSLayoutAttribute.centerX,
                                     multiplier: 1,
                                     constant: 0)
    let centerY = NSLayoutConstraint(item: titleLabel,
                                     attribute: NSLayoutAttribute.centerY,
                                     relatedBy: NSLayoutRelation.equal,
                                     toItem: self.contentView,
                                     attribute: NSLayoutAttribute.centerY,
                                     multiplier: 1,
                                     constant: 0)
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addConstraints([centerX, centerY])
  }

  private func setContainerView() {
    containerView.layer.masksToBounds = true
    containerView.layer.cornerRadius = 16
    containerView.frame = self.contentView.bounds

    self.addSubview(containerView)

    containerView.translatesAutoresizingMaskIntoConstraints = false
//    let leadingConstraint = NSLayoutConstraint(item: containerView,
//                                               attribute: .leading,
//                                               relatedBy: .equal,
//                                               toItem: nil,
//                                               attribute: .leading,
//                                               multiplier: 1,
//                                              constant: 20).isActive = true
//    let trailingConstraint = NSLayoutConstraint(item: containerView,
//                                                attribute: .trailing,
//                                                relatedBy: .equal,
//                                                toItem: nil,
//                                                attribute: .trailing,
//                                                multiplier: 1,
//                                                constant: 20)

//    containerView.addConstraints([leadingConstraint, trailingConstraint])
//    containerView.addConstraint(leadingConstraint)
//    containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24).isActive = true
//    containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24).isActive = true
//    containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//    containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }

  private func setContentView() {
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.addSubview(contentView)

    contentView.translatesAutoresizingMaskIntoConstraints = false

    let margins = self.layoutMarginsGuide

    contentView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    contentView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 8).isActive = true
    contentView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 8).isActive = true

    contentView.backgroundColor = .lightGray
  }

  private func loadView() {
    setContentView()

    setTitleLabel()

    setContainerView()
  }
}
