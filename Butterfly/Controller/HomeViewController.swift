//
//  HomeViewController.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/6.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initUI()
    }
    
    private func initUI() {
        self.title = "青娥"
        self.tableView.backgroundColor = UIColor.background
        self.navigationController?.navigationBar.barTintColor = UIColor.background
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.themeColor]
        self.navigationController?.navigationBar.tintColor = UIColor.themeColor
        
        let rightItem = UIBarButtonItem(image: #imageLiteral(resourceName: "more"), style: .plain, target: self, action: #selector(HomeViewController.pushToSettingsPage(_:)))
        self.navigationItem.rightBarButtonItem = rightItem
        
        self.tableView = UITableView(frame: self.tableView.frame, style: UITableView.Style.grouped)
        self.tableView.backgroundColor = UIColor.background
        self.tableView.separatorStyle = .none
        self.tableView.register(ImageScrollTalbeCell.self, forCellReuseIdentifier: "cell")
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
            imageCell.delegate = self
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleLabel = UILabel()
        titleLabel.text = "today" //TODO 数据输入
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.darkRed
        return titleLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

extension HomeViewController: ImageScrollTableCellDelegate {
    func imageScrollTableCell(tableCell: ImageScrollTalbeCell, data: Any?) {
        print(90)
    }
}
