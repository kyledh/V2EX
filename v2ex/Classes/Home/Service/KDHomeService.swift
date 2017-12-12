//
//  KDHomeService.swift
//  v2ex
//
//  Created by donghao on 2017/10/4.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

extension KDAPIClient {
    
    func fetchHotNodes(success: ((_ response: NSArray?) -> ())?, failure: FailureClosure?) {
        // TODO: 获取热门节点
        // 手动..............
        success?([
            ["title": "全部", "name": "all"],
            ["title": "最热", "name": "hot"],
            ["title": "技术", "name": "tech"],
            ["title": "创意", "name": "creative"],
            ["title": "Apple", "name": "apple"],
            ["title": "好玩", "name": "play"],
            ["title": "城市", "name": "city"],
            ["title": "交易", "name": "deals"],
            ["title": "R2", "name": "r2"],
            ["title": "酷工作", "name": "jobs"],
            ["title": "问与答", "name": "qna"],
            ])
    }
}
