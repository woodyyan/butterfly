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
        self.navigationController?.navigationBar.tintColor = UIColor.background
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.themeColor]
        self.navigationController?.navigationBar.tintColor = UIColor.themeColor
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(HomeViewController.pushToSettingsPage(_:)))
        self.navigationItem.rightBarButtonItem = rightItem
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.themeColor
    }
    
    @objc func pushToSettingsPage(_ sender: UIBarButtonItem) {
//        let settingsController = SettingsViewController()
//        self.navigationController?.pushViewController(settingsController, animated: true)
    }
}
