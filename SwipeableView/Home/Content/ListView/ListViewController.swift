//
//  ListViewController.swift
//  SwipeableView
//
//  Created by William on 04/11/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, PagedStreamView {
    var currentView: UIView {
        return self.view
    }
    
    var currentPage: Int = 0

    init(currentPage: Int = 0) {
        self.currentPage = currentPage

        super.init(nibName: "ListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
