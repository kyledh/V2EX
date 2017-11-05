//
//  KDBorderLineView.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

import SnapKit

extension UIView {
    
    func borderLine() -> UIView {
        let borderLine = UIView()
        borderLine.backgroundColor = KDUIKitUtils.HEXCOLOR("e2e2e2")
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
