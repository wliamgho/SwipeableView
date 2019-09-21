//
//  HomeViewController.swift
//  SwipeableView
//
//  Created by William on 21/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var listData: [[String: Any]] = [[String: Any]]()

    @IBOutlet weak var cardView: CardView!

    init() {
        super.init(nibName: "HomeViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getStatus()
        getList()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        debugPrint("list data", self.listData)
    }

    func getStatus() {
      // Load json file
      if let path = Bundle.main.path(forResource: "Status", ofType: "json") {
          do {
              let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                  options: .mappedIfSafe)
              let jsonResult = try JSONSerialization.jsonObject(with: data, options: [])

              if let result = jsonResult as? [[String: Any]] {
                  self.listData = result
              }
          } catch {
              debugPrint("ERROR to read json file", error.localizedDescription)
          }
      }
    }

    func getList() {
      // Load json file
      if let path = Bundle.main.path(forResource: "List", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: [])
          } catch {
              debugPrint("ERROR to read json file", error.localizedDescription)
          }
      }
    }
}
