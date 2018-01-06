//
//  KDUIKitUtils.swift
//  qducc
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func hex(_ value: String) -> UIColor? {
        return hex(value: value, alpha: 1.0)
    }
    
    class func hex(value: String, alpha: CGFloat) -> UIColor? {
        guard let hexValue = Int(value, radix:16) else { return nil }
        return UIColor(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((hexValue & 0xFF00) >> 8) / 255.0, blue: CGFloat(hexValue & 0xFF) / 255.0, alpha: alpha)
    }
}
