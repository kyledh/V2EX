//
//  KDUIKitUtils.swift
//  qducc
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDUIKitUtils {
    
    class func SCREEN_WIDTH() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    class func SCREEN_HEIGHT() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
}

extension UIColor {
    
    class func HEXCOLOR(_ value: String) -> UIColor {
        return HEXCOLOR(value: value, alpha: 1.0)
    }
    
    class func HEXCOLOR(value: String, alpha: CGFloat) -> UIColor {
        let hexValue = Int(value, radix:16)
        return UIColor.init(red: CGFloat((hexValue! & 0xFF0000) >> 16) / 255.0, green: CGFloat((hexValue! & 0xFF00) >> 8) / 255.0, blue: CGFloat(hexValue! & 0xFF) / 255.0, alpha: alpha)
    }
}
