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
    
    private let viewModel: SettingsViewModel = ViewModelFactory.shared.create()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initUI()
    }
    
    private func initUI() {
        self.title = "设置"
        self.tableView.backgroundColor = UIColor.background
        self.navigationController?.navigationBar.barTintColor = UIColor.background
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.tableView = UITableView(frame: self.tableView.frame, style: UITableView.Style.grouped)
        self.tableView.backgroundColor = UIColor.background
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let footerImage = UIImageView(image: #imageLiteral(resourceName: "butterfly"))
        let footerView = UIView()
        footerView.addSubview(footerImage)
        footerImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
        }
        footerView.frame.size = CGSize(width: self.tableView.frame.width, height: 72)
        self.tableView.tableFooterView = footerView
    }
}

extension SettingsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settings.getSection(index: section).count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.settings.sections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let settingItem = viewModel.settings.getSettingItem(indexPath)
        if let detailText = settingItem.detailText {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
            cell.detailTextLabel?.text = detailText
            cell.detailTextLabel?.textColor = UIColor.themeColor
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        }
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor.settingCell
        cell.textLabel?.text = settingItem.title
        cell.textLabel?.textColor = UIColor.white
        if let name = settingItem.icon {
            cell.imageView?.image = UIImage(named: name)
        }
        return cell
    }
}
