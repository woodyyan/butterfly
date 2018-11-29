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
    
    private let feedbackKit = BCFeedbackKit(appKey: "25334645", appSecret: "49b52bef285ff074ee2249227f710eb6")
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ALBBMANPageHitHelper.getInstance()?.pageAppear(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ALBBMANPageHitHelper.getInstance()?.pageDisAppear(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.initSettings()
        initUI()
    }
    
    private func initUI() {
        self.title = "设置"
        self.tableView.backgroundColor = UIColor.background
        self.navigationController?.navigationBar.barTintColor = UIColor.background
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.themeColor]
        self.navigationController?.navigationBar.tintColor = UIColor.themeColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.tableView = UITableView(frame: self.tableView.frame, style: UITableView.Style.grouped)
        self.tableView.backgroundColor = UIColor.background
        self.tableView.separatorColor = UIColor.background
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
        
        handleAction(indexPath: indexPath)
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
    
    private func handleAction(indexPath: IndexPath) {
        if indexPath.section == 0 {
            pushToSubController()
        } else if indexPath.section == 1 {
            pushToFavController()
        } else if indexPath.section == 2 && indexPath.row == 0 {
            share()
        } else if indexPath.section == 2 && indexPath.row == 1 {
            commentInAppStore()
        } else if indexPath.section == 2 && indexPath.row == 2 {
            feedback()
        } else if indexPath.section == 3 {
            openAboutController()
        }
    }
    
    private func pushToFavController() {
        let favViewController = FavViewController()
        self.navigationController?.pushViewController(favViewController, animated: true)
    }
    
    private func share() {
        if let url = URL(string: Configs.appStoreUrl) {
            let controller = UIActivityViewController(activityItems: ["分享给朋友", url, UIImage.init(named: "AppIcon")!], applicationActivities: [])
            controller.excludedActivityTypes = [.addToReadingList, .assignToContact, .openInIBooks, .saveToCameraRoll]
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    private func commentInAppStore() {
        if let url = URL(string: Configs.appStoreUrl) {
            UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey: Any](), completionHandler: nil)
        }
    }
    
    private func openAboutController() {
        let aboutViewController = AboutViewController()
        self.navigationController?.pushViewController(aboutViewController, animated: true)
    }
    
    private func pushToSubController() {
        let subViewController = SubViewController()
        self.present(subViewController, animated: true, completion: nil)
    }
    
    private func feedback() {
        feedbackKit?.extInfo = [
            "app_version": Bundle.main.getVersion(),
            "device_model": UIDevice.current.model
        ]
        feedbackKit?.makeFeedbackViewController(completionBlock: { (controller, error) in
            print(error ?? "")
            if let feedbackController = controller {
                self.navigationController?.pushViewController(feedbackController, animated: true)
                feedbackController.closeBlock = { controller in
                    controller?.navigationController?.popViewController(animated: true)
                }
            }
        })
    }
}
