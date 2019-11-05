//
//  AlternativeViewController.swift
//  SwipeableView
//
//  Created by William on 05/11/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class AlternativeViewController: UIViewController {
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var collectionView: UICollectionView!

    private(set) var pullToRefresh = PullToRefresh()
    private var viewPager: PageViewController!
    
    var listData: [String] = ["SLIDE 1", "SLIDE 2", "SLIDE 3", "SLIDE 4", "List"]
    var collectionData: [String] = ["Test", "Test 1", "Test 2", "Test 3"]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionLayout()

        configureViewPager()

        collectionView.register(UINib(nibName: ItemListCell.reuseIdentifier(),
                                      bundle: nil), forCellWithReuseIdentifier: ItemListCell.reuseIdentifier())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewPager.didMove(toParent: self)
    }

    private func configureCollectionLayout() {
        var contentInset = UIEdgeInsets(top: 250,
                                        left: 0, bottom: 0, right: 0)
        if #available(iOS 11.0, *), let window = UIApplication.shared.keyWindow {
            contentInset.top -= (window.safeAreaInsets.top)
        }

        collectionView.contentInset = contentInset
        collectionView.scrollIndicatorInsets = collectionView.contentInset
        collectionView.refreshControl = pullToRefresh
        pullToRefresh.delegate = self

        headerView.observeOn(controller: self)
        headerView.observeOn(scrollView: collectionView)
    }

    private func configureViewPager() {
        viewPager = PageViewController(listData: listData)
        viewPager.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        headerView.cardView.addSubview(viewPager.view)
    }
}

extension AlternativeViewController: UICollectionViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: ItemListCell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemListCell.reuseIdentifier(), for: indexPath) as! ItemListCell
        cell.itemLabel.text = collectionData[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ItemListCell.size()
    }
}

// MARK: - PullToRefreshDelegate
extension AlternativeViewController: PullToRefreshDelegate {
    func beginRefreshing() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          self.pullToRefresh.endRefreshing()
        }
    }
}
