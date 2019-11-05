//
//  CustomHeaderView.swift
//  SwipeableView
//
//  Created by William on 05/11/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class CustomHeaderView: UIView {
    @IBOutlet var contentView: UIView!

    private(set) var observer: NSKeyValueObservation?
    private(set) var viewControlelr: UIViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)

        loadNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        loadNib()
    }

    private func loadNib() {
        Bundle.main.loadNibNamed("CustomHeaderView", owner: self, options: nil)

        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(content)
    }

    func observeOn(scrollView: UIScrollView) {
        observer = scrollView.observe(\UIScrollView.contentOffset, options: [.new, .old]) { (scrollView, value) in
            if let oldOffset = value.oldValue, let newOffset = value.newValue {
                self.handleExpandable(forScrollView: scrollView,
                                      from: oldOffset.y + scrollView.contentInset.top,
                                      to: newOffset.y + scrollView.contentInset.top)
            }
        }
    }

//    func observeOn(controller viewController: UIViewController) {
//        self.viewControlelr = viewController
//    }

    /// Handle Expandable Header When Scrolling event.
    ///
    /// - Parameters:
    ///   - scrollView: scrollView object
    ///   - oldOffset: old scrollView event with Y offset
    ///   - newOffset: new scrollView event with Y offset
    private func handleExpandable(forScrollView scrollView: UIScrollView,
                                  from oldOffset: CGFloat,
                                  to newOffset: CGFloat) {
        let contentOffsetY = abs(min(0, scrollView.contentOffset.y))
        var expandHeader = max(0, contentOffsetY)
        let percentage = contentOffsetY / scrollView.contentInset.top

        debugPrint("expandheader", expandHeader)
        if expandHeader <= 340 - 100 {
            UIView.animate(withDuration: 0.3) {
//                self.cardView.alpha = percentage
//                self.contentView.alpha = percentage
                
//                self.cardView.frame.origin.y = 0
                self.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3) {
//                self.contentView.alpha = percentage
//                self.cardView.alpha = percentage

//                self.cardView.frame.origin.y = 160
                self.layoutIfNeeded()
            }
        }

        if oldOffset < newOffset {
            // Scroll top
            if expandHeader > 0 {
                expandHeader = min(250, contentOffsetY)
            } else {
                expandHeader = max(0, contentOffsetY)
            }
        } else if oldOffset >= newOffset {
            // Scroll down
            if expandHeader > 250 {
                expandHeader = min(250, contentOffsetY)
            } else {
                expandHeader = max(0, contentOffsetY)
            }
        }

        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: expandHeader)
    }
}
