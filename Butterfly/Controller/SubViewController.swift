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
    
    private let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    weak var delegate: Subscription?
    
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
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.stopAnimating()
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
        return 13
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
        case 8:
            return 50
        case 9:
            return 100
        case 10:
            return 60
        default:
            return 44
        }
    }
    
    // swiftlint:disable cyclomatic_complexity
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
        case 8:
            return getSubDescriptionCell()
        case 9:
            return getDescriptionDetailCell()
        case 10:
            return getTermButtonsCell()
        case 11:
            return getRestorPurchaseButtonsCell()
        default:
            return UITableViewCell()
        }
    }
    
    private func getRestorPurchaseButtonsCell() -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        
        let restoreButton = UIButton(type: UIButton.ButtonType.system)
        
        restoreButton.setAttributedTitle("恢复购买".toUnderlineString(UIColor.gray), for: UIControl.State.normal)
        restoreButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        restoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        restoreButton.addTarget(self, action: #selector(SubViewController.restorePurchase(_:)), for: UIControl.Event.touchUpInside)
        
        cell.addSubview(restoreButton)
        restoreButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        return cell
    }
    
    private func getTermButtonsCell() -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        
        let termsOfUseButton = UIButton(type: UIButton.ButtonType.system)
        
        termsOfUseButton.setAttributedTitle("服务条款".toUnderlineString(UIColor.gray), for: UIControl.State.normal)
        termsOfUseButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        termsOfUseButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        termsOfUseButton.addTarget(self, action: #selector(SubViewController.openTermsPage(_:)), for: UIControl.Event.touchUpInside)
        
        let privacyPolicyButton = UIButton(type: UIButton.ButtonType.system)
        privacyPolicyButton.setAttributedTitle("隐私政策".toUnderlineString(UIColor.gray), for: UIControl.State.normal)
        privacyPolicyButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        privacyPolicyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        privacyPolicyButton.addTarget(self, action: #selector(SubViewController.openPrivacyPolicy(_:)), for: UIControl.Event.touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [termsOfUseButton, privacyPolicyButton])
        stackView.axis = .horizontal
        stackView.spacing = 100
        cell.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        return cell
    }
    
    @objc func openPrivacyPolicy(_ sender: UIButton) {
        let controller = WebViewController()
        controller.title = "服务条款"
        controller.resource = "PrivacyPolicy"
        self.present(controller, animated: true, completion: nil)
    }
    
    @objc func openTermsPage(_ sender: UIButton) {
        let controller = WebViewController()
        controller.title = "隐私政策"
        controller.resource = "UserAgreement"
        self.present(controller, animated: true, completion: nil)
    }
    
    @objc func restorePurchase(_ sender: UIButton) {
        indicator.startAnimating()
        SubscriptionManager.shared.restorePurchase { (success, message) in
            self.indicator.stopAnimating()
            if success {
                MessageBox.show("恢复成功")
                self.delegate?.subscribed()
            } else {
                MessageBox.show(message)
            }
        }
    }
    
    private func getDescriptionDetailCell() -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        let textLabel = UILabel()
        textLabel.text = """
        确认购买后，将通过您的iTunes账户付款。
        
        自动续期订阅的Apple ID，
        会在每个账单周期到期前24小时，
        自动在iTunes账户扣费并延长6个月有效期。
        
        在订阅期间，您可以通过个人iTunes账户取消订阅。
        并需在现有计划到期之际，至少提前24小时进行取消操作。
        """
        textLabel.numberOfLines = 8
        textLabel.textColor = UIColor.gray
        textLabel.font = UIFont.systemFont(ofSize: 10)
        cell.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(70)
            make.centerY.equalToSuperview()
        }
        return cell
    }
    
    private func getSubDescriptionCell() -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = "订阅须知"
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textColor = UIColor.darkGray
        cell.contentMode = .center
        return cell
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
        priceLabel.text = "¥88/1年"
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
        button.addTarget(self, action: #selector(SubViewController.subscribeByYear(_:)), for: UIControl.Event.touchUpInside)
        
        cell.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.equalTo(240)
            make.height.equalTo(36)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        return cell
    }
    
    @objc func subscribeByMonth(_ sender: UIButton) {
        subscribe(type: SubscriptionType.monthly)
    }
    
    @objc func subscribeByYear(_ sender: UIButton) {
        subscribe(type: SubscriptionType.yearly)
    }
    
    private func subscribe(type: SubscriptionType) {
        let builder = ALBBMANCustomHitBuilder.init()
        builder.setEventLabel("订阅点击")
        builder.setEventPage("订阅")
        builder.setProperty("type", value: String(type.rawValue))
        let traker = ALBBMANAnalytics.getInstance()?.getDefaultTracker()
        traker?.send(builder.build())
        
        indicator.startAnimating()
        SubscriptionManager.shared.purchase(type: type) { (success, message) in
            self.indicator.stopAnimating()
            if success {
                MessageBox.show("订阅成功")
                self.delegate?.subscribed()
            } else {
                MessageBox.show(message)
            }
        }
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
        button.addTarget(self, action: #selector(SubViewController.subscribeByMonth(_:)), for: UIControl.Event.touchUpInside)
        
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

protocol Subscription: NSObjectProtocol {
    func subscribed()
}
