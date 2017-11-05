//
//  KDTopicService.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

extension KDAPIClient {

    func fetchTopicsWithNode(nodeName: String, success: @escaping (_ responseObject: String?) -> (), failture: @escaping (_ error: NSError?) -> ()) {
        let params = ["tab": nodeName as AnyObject]
        self.getRequest(path: nil, params: params, success: { (data) in
            if data is String {
                success(data as? String)
            } else {
                failture(nil)
            }
        }) { (error) in
            failture(error)
        }
    }
}
