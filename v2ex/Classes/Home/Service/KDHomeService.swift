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
        success([["title": "全部", "name": "all"], ["title": "热门", "name": "hot"]])
    }
}
