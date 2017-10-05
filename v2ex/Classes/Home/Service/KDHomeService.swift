//
//  KDHomeService.swift
//  v2ex
//
//  Created by donghao on 2017/10/4.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

extension KDAPIClient {
    
    func fetchHotNodes(success: @escaping (_ responseObject: NSArray?) -> (), failture: @escaping (_ error: NSError?) -> ()) {
        // TODO: 获取热门节点
        // 手动..............
        success([
            ["title": "全部", "name": "all"],
            ["title": "最热", "name": "hot"],
            ["title": "技术", "name": "tech"],
            ["title": "Apple", "name": "apple"],
            ["title": "酷工作", "name": "jobs"],
            ["title": "分享发现", "name": "share"],
            ["title": "二手交易", "name": "all4all"],
            ["title": "问与答", "name": "qna"]
            ])
    }
}
