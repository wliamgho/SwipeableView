//
//  CircularView.swift
//  SwipeableView
//
//  Created by William on 25/04/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class CircularView: UIView {
  @IBInspectable var progressColor = UIColor.white {
    didSet {
      self.progressLayer.strokeColor = self.progressColor.cgColor
    }
  }
  
  @IBInspectable var trackColor = UIColor.white {
    didSet {
      self.trackLayer.strokeColor = self.trackColor.cgColor
    }
  }
  
  @IBInspectable var setProgress: CGFloat = 0 {
    didSet {
      self.progressLayer.strokeEnd = setProgress
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    configureLayout()
  }
  
  var progressLayer = CAShapeLayer()
  var trackLayer = CAShapeLayer()
  
  private var pathCenter: CGPoint {
    return self.convert(self.center, from: self.superview)
  }
  
  private func configureLayout() {
    self.layer.cornerRadius = self.frame.size.width/2
    
    let startAngle = (-CGFloat.pi/2)
    let endAngle = 2 * CGFloat.pi + startAngle
    let lineWidth: CGFloat = 2
    
    // Instance track layer
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2,
                                                     y: frame.size.height/2),
                                  radius: (frame.size.width - lineWidth)/2,
                                  startAngle: startAngle,
                                  endAngle: endAngle,
                                  clockwise: true)
    trackLayer.path = circlePath.cgPath
    trackLayer.fillColor = UIColor.clear.cgColor
    trackLayer.strokeColor = self.trackColor.cgColor
    trackLayer.lineWidth = 3.0
    trackLayer.strokeEnd = 1.0
    
    layer.addSublayer(trackLayer)
    
    // Instance progress layer
    progressLayer.lineCap = CAShapeLayerLineCap.round
    progressLayer.path = circlePath.cgPath
    progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.strokeColor = UIColor.clear.cgColor
    progressLayer.lineWidth = lineWidth
    progressLayer.strokeEnd = 0.0
    
    layer.addSublayer(progressLayer)

    // Add Image
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    profileImageView.clipsToBounds = true
    profileImageView.image = UIImage(named: "ic_profile")
    self.addSubview(profileImageView)
    self.bringSubviewToFront(profileImageView)
  }
}
