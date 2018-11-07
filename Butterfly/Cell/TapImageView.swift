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
    override init(image: UIImage?) {
        super.init(image: image)
        
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(TapImageView.tapImage(_:)))
        self.addGestureRecognizer(gesture)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func tapImage(_ sender: UITapGestureRecognizer) {
        print(9)
    }
}
