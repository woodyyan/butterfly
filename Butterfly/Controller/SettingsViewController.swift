//
//  SettingViewController.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/7.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initUI()
    }
    
    private func initUI() {
        self.title = "设置"
        self.tableView.backgroundColor = UIColor.background
        self.navigationController?.navigationBar.barTintColor = UIColor.background
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.themeColor]
        self.navigationController?.navigationBar.tintColor = UIColor.themeColor
    }
}
