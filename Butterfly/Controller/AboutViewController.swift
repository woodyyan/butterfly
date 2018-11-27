//
//  AboutViewController.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/10.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class AboutViewController: UIViewController {
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
        
        self.title = "关于"
        self.view.backgroundColor = UIColor.background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        
        initUI()
    }
    
    private func initUI() {
        let iconImage = UIImageView(image: #imageLiteral(resourceName: "butterflyBig"))
        self.view.addSubview(iconImage)
        iconImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(120)
        }
        
        let title = UILabel()
        title.text = "青娥"
        title.textColor = UIColor.themeColor
        self.view.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconImage)
            make.top.equalTo(iconImage.snp.bottom).offset(10)
        }
        
        let version = UILabel()
        version.text = "Version 2.2"
        version.textColor = UIColor.gray
        version.font = UIFont.systemFont(ofSize: 12)
        self.view.addSubview(version)
        version.snp.makeConstraints { (make) in
            make.centerX.equalTo(title)
            make.top.equalTo(title.snp.bottom).offset(20)
        }
        
        let termsOfUse = UIButton(type: UIButton.ButtonType.system)
        termsOfUse.setTitle("使用条款", for: UIControl.State.normal)
        self.view.addSubview(termsOfUse)
        termsOfUse.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(version.snp.bottom).offset(30)
//            make.width.equalTo(100)
//            make.height.equalTo(25)
        }
        
        let privacyPolicy = UIButton(type: UIButton.ButtonType.system)
        privacyPolicy.setTitle("隐私政策", for: UIControl.State.normal)
        self.view.addSubview(privacyPolicy)
        privacyPolicy.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(termsOfUse.snp.bottom).offset(10)
//            make.width.equalTo(100)
//            make.height.equalTo(25)
        }
        
        let copyright = UILabel()
        copyright.text = "© 2018 青娥 Team"
        copyright.font = UIFont.systemFont(ofSize: 10)
        copyright.textColor = UIColor.gray
        self.view.addSubview(copyright)
        copyright.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}
