//
//  HomeViewController.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/6.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import UIKit
import ESPullToRefresh

class HomeViewController: UITableViewController {
    
    let viewModel: HomeViewModel = ViewModelFactory.shared.create()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.delegate = self
        initUI()
    }
    
    private func initUI() {
        self.title = "青娥"
        self.tableView.backgroundColor = UIColor.background
        self.navigationController?.navigationBar.barTintColor = UIColor.background
        self.navigationController?.navigationBar.backgroundColor = UIColor.background
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.themeColor]
        self.navigationController?.navigationBar.tintColor = UIColor.themeColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        
        let rightItem = UIBarButtonItem(image: #imageLiteral(resourceName: "more"), style: .plain, target: self, action: #selector(HomeViewController.pushToSettingsPage(_:)))
        self.navigationItem.rightBarButtonItem = rightItem
        
        self.tableView = UITableView(frame: self.tableView.frame, style: UITableView.Style.grouped)
        self.tableView.backgroundColor = UIColor.background
        self.tableView.separatorStyle = .none
        self.tableView.register(ImageScrollTalbeCell.self, forCellReuseIdentifier: "cell")
        
        initPullToRefresh()
    }
    
    private func initPullToRefresh() {
        self.tableView.expiredTimeInterval = 15.0
        
        self.tableView.es.addPullToRefresh(animator: ButterflyRefreshAnimator.init()) {
            [unowned self] in
            self.viewModel.fetchNewFromServer()
        }
        
        self.tableView.es.addInfiniteScrolling(animator: ButterflyFooterAnimator.init()) {
            [unowned self] in
            self.viewModel.fetchMoreFromServer()
        }
    }
    
    @objc func pushToSettingsPage(_ sender: UIBarButtonItem) {
        let settingsController = SettingsViewController()
        self.navigationController?.pushViewController(settingsController, animated: true)
    }
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let imageCell = cell as? ImageScrollTalbeCell {
            imageCell.initUI(butterfly: viewModel.butterflySections[indexPath.section].butterflies[indexPath.row])
            imageCell.delegate = self
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleLabel = UILabel()
        titleLabel.text = viewModel.butterflySections[section].title
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.darkRed
        return titleLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.butterflySections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.butterflySections[section].count
    }
}

extension HomeViewController: ImageScrollTableCellDelegate {
    
    func imageScrollTableCell(tableCell: ImageScrollTalbeCell, butterfly: Butterfly, selected: Int) {
        let pictureViewController = PictureViewController()
        pictureViewController.viewModel.butterfly = butterfly
        pictureViewController.viewModel.isFromFav = false
        pictureViewController.viewModel.currentSelected = selected
        self.navigationController?.pushViewController(pictureViewController, animated: true)
    }
}

extension HomeViewController: FetchButterflyDelegate {
    func fetchButterfly(viewModel: HomeViewModel, success: Bool, isPullRefresh: Bool) {
        if isPullRefresh {
            self.tableView.es.stopPullToRefresh(ignoreDate: true)
        } else {
            if success {
                self.tableView.es.stopLoadingMore()
            } else {
                self.tableView.es.noticeNoMoreData()
            }
        }
        if success {
            self.tableView.reloadData()
        }
    }
}
