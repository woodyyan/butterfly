//
//  TapImageView.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/7.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import UIKit

class TapImageView: UIImageView {
    
    var picture = ""
    
    weak var delegate: TapImageViewDelegate?
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        self.layer.cornerRadius = Configs.cornerRadius
        self.layer.masksToBounds = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(TapImageView.tapImage(_:)))
        self.addGestureRecognizer(gesture)
        self.isUserInteractionEnabled = true
        
        self.contentMode = .scaleAspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func tapImage(_ sender: UITapGestureRecognizer) {
        delegate?.tapImageView(imageView: self)
    }
}

protocol TapImageViewDelegate: NSObjectProtocol {
    func tapImageView(imageView: TapImageView)
}
