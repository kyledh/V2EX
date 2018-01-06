//
//  KDLayoutView.swift
//  v2ex
//
//  Created by donghao on 2017/10/5.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

extension UIView {

    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom: CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
}

extension UIView {
    
    func borderLine() -> UIView {
        let borderLine = UIView()
        borderLine.backgroundColor = UIColor.hex("e2e2e2")
        addSubview(borderLine)
        return borderLine
    }
    
    func leftLine() {
        let leftLine = borderLine()
        leftLine.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(0.5)
        }
    }
    
    func rightLine() {
        let rightLine = borderLine()
        rightLine.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(self)
            make.width.equalTo(0.5)
        }
    }
    
    func bottomLine() {
        let bottomLine = borderLine()
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(0.5)
        }
    }
    
    func topLine() {
        let topLine = borderLine()
        topLine.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(0.5)
        }
    }
}
