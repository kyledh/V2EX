//
//  KDLayoutView.swift
//  v2ex
//
//  Created by donghao on 2017/10/5.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

extension UIView {

    func left() -> CGFloat {
        return self.frame.origin.x
    }
    
    func right() -> CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    
    func top() -> CGFloat {
        return self.frame.origin.y
    }
    
    func bottom() -> CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    
    func width() -> CGFloat {
        return self.frame.size.width
    }
    
    func height() -> CGFloat {
        return self.frame.size.height
    }
}
