//
//  WebViewController.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/28.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import UIKit

class WebViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ALBBMANAnalytics.getInstance().getDefaultTracker().pageAppear(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ALBBMANAnalytics.getInstance().getDefaultTracker().pageDisAppear(self)
    }
    
    var resource: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        
        let webView = UIWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        if let path = Bundle.main.path(forResource: resource, ofType: "html") {
            let url = URL(fileURLWithPath: path)
            let urlRequest = URLRequest(url: url)
            webView.loadRequest(urlRequest)
        }
        
        let closeButton = UIButton(type: UIButton.ButtonType.custom)
        closeButton.frame = CGRect(x: 300, y: 30, width: closeButton.width, height: closeButton.height)
        closeButton.setImage(#imageLiteral(resourceName: "close"), for: UIControl.State.normal)
        closeButton.addTarget(self, action: #selector(WebViewController.dismiss(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    @objc func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
