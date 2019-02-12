//
//  MenuBar.swift
//  SwipeableView
//
//  Created by William on 09/02/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

protocol MenuBarDelegate {
    func menuItemDidTouch(withIndex index: Int)
}

class MenuBar: UIView {
    var buttonTitle =  "" {
        didSet {
            didSetButtonTitle()
        }
    }

    var indicatorActive = 0 {
        didSet {
            didSetIndicatorActive()
        }
    }

    @IBOutlet var contentView: UIView!

    @IBOutlet weak var alphaButton: UIButton!
    @IBOutlet weak var alphaIndicator: UIView!

    @IBOutlet weak var betaButton: UIButton!
    @IBOutlet weak var betaIndicator: UIView!

    var delegate: MenuBarDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        loadNib()
    }

    private func loadNib() {
        Bundle.main.loadNibNamed("MenuBar", owner: self, options: nil)

        guard let content = contentView else { return }

        content.frame = self.bounds
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(content)
    }

    private func didSetButtonTitle() {
        alphaButton.titleLabel?.text = buttonTitle
        betaButton.titleLabel?.text = buttonTitle
    }

    private func didSetIndicatorActive() {
        if indicatorActive == 0 {
            alphaIndicator.alpha = 1
            betaIndicator.alpha = 0.4
        } else {
            alphaIndicator.alpha = 0.4
            betaIndicator.alpha = 1
        }
    }

    @IBAction func alphaDidTouch(_ sender: UIButton) {
        delegate?.menuItemDidTouch(withIndex: sender.tag)
    }

    @IBAction func betaDidTouch(_ sender: UIButton) {
        delegate?.menuItemDidTouch(withIndex: sender.tag)
    }
}
