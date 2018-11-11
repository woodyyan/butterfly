//
//  SubViewController.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/10.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SubViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorStyle = .none
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: 50))
        
        initUI()
    }
    
    private func initUI() {
        let closeButton = UIButton(type: UIButton.ButtonType.custom)
        closeButton.frame = CGRect(x: 300, y: 30, width: closeButton.width, height: closeButton.height)
        closeButton.setImage(#imageLiteral(resourceName: "close"), for: UIControl.State.normal)
        closeButton.addTarget(self, action: #selector(SubViewController.dismiss(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(self.tableView.width - 20)
        }
    }
    
    @objc func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension SubViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getCell(by: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 100
        case 1:
            return 70
        case 2, 3, 4:
            return 28
        case 5:
            return 20
        case 6:
            return 50
        case 7:
            return 50
        default:
            return 44
        }
    }
    
    private func getCell(by indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return getIconCell()
        case 1:
            return getTitleCell()
        case 2:
            return getAdvanceFeatureCell(title: "无限制查看高清图片")
        case 3:
            return getAdvanceFeatureCell(title: "无限制下载高清图片")
        case 4:
            return getAdvanceFeatureCell(title: "移除广告")
        case 6:
            return getMonthMemberButtonCell()
        case 7:
            return getYearMemberButtonCell()
        default:
            return UITableViewCell()
        }
    }
    
    private func getYearMemberButtonCell() -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        
        let button = UIButton(type: UIButton.ButtonType.custom)
        let titleLable = UILabel()
        titleLable.text = "年会员"
        titleLable.textColor = UIColor.white
        titleLable.font = UIFont.systemFont(ofSize: 12)
        button.addSubview(titleLable)
        titleLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(18)
            make.centerY.equalToSuperview()
        }
        let priceLabel = UILabel()
        priceLabel.text = "¥96/1年"
        priceLabel.textColor = UIColor.white
        priceLabel.font = UIFont.systemFont(ofSize: 12)
        button.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-26)
            make.centerY.equalToSuperview()
        }
        
        let image = UIImageView(image: #imageLiteral(resourceName: "bookmark"))
        button.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-26)
        }
        button.backgroundColor = UIColor.background
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        
        cell.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.equalTo(240)
            make.height.equalTo(36)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        return cell
    }
    
    private func getMonthMemberButtonCell() -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        
        let button = UIButton(type: UIButton.ButtonType.custom)
        let titleLable = UILabel()
        titleLable.text = "月会员"
        titleLable.textColor = UIColor.background
        titleLable.font = UIFont.systemFont(ofSize: 12)
        button.addSubview(titleLable)
        titleLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(18)
            make.centerY.equalToSuperview()
        }
        let priceLabel = UILabel()
        priceLabel.text = "¥12/1个月"
        priceLabel.textColor = UIColor.background
        priceLabel.font = UIFont.systemFont(ofSize: 12)
        button.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-18)
            make.centerY.equalToSuperview()
        }
        button.layer.borderColor = UIColor.background.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        
        cell.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.equalTo(240)
            make.height.equalTo(36)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        return cell
    }
    
    private func getAdvanceFeatureCell(title: String) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        
        let image = UIImageView(image: #imageLiteral(resourceName: "check@X1"))
        let textLabel = UILabel()
        textLabel.text = title
        textLabel.textColor = UIColor.darkGray
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 12)
        
        let stackView = UIStackView(arrangedSubviews: [image, textLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        cell.contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(100)
        }
        return cell
    }
    
    private func getTitleCell() -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = "订阅会员"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    private func getIconCell() -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        let image = UIImageView(image: #imageLiteral(resourceName: "butterflyBig"))
        cell.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
        }
        return cell
    }
}
