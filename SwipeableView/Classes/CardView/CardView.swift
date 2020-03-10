//
//  CardView.swift
//  SwipeableView
//
//  Created by William on 10/03/20.
//

import UIKit

public class CardView: UIView {
  var contentView = UIView()
  var titleLabel = UILabel()
  var containerView = UIView()

  private var shadowLayer: CAShapeLayer!

  override init(frame: CGRect) {
    super.init(frame: frame)

    loadView()
  }

  public init(title: String) {
    super.init(frame: .zero)

    self.titleLabel.text = title
    loadView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)

    loadView()
  }

  public override func layoutSubviews() {
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

    self.addSubview(containerView)

    containerView.translatesAutoresizingMaskIntoConstraints = false

    containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }

  private func setContentView() {
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.addSubview(contentView)
  }

  private func loadView() {
    setContentView()

    setTitleLabel()

    setContainerView()
  }}
