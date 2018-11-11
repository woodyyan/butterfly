//
//  StringExtension.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/11.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import UIKit

extension String {
    func toUnderlineString(_ color: UIColor) -> NSMutableAttributedString {
        let string = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: string.length)
        let number = NSNumber(value: NSUnderlineStyle.single.rawValue)
        string.addAttribute(NSAttributedString.Key.underlineStyle, value: number, range: range)
        string.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        return string
    }
}
