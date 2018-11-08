//
//  UIColorExtension.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/6.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation

import Foundation
import UIKit

extension UIColor {
    public static var themeColor: UIColor {
        return UIColor(red: 236, green: 106, blue: 92)!
    }
    
    public static var background: UIColor {
        return UIColor(red: 46, green: 46, blue: 46)!
    }
    
    public static var darkRed: UIColor {
        return UIColor(red: 175, green: 64, blue: 52)!
    }
    
    public static var settingCell: UIColor {
        return UIColor(red: 65, green: 66, blue: 67)!
    }
    
    public convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }
        
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
}
