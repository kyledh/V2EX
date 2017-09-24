//
//  KDTopicService.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

extension KDAPIClient {

    func fetchTopicsLatest(success: @escaping (_ responseObject: NSArray?) -> (), failture: @escaping (_ error: NSError?) -> ()) {
        self.getRequestWithoutCache(path: "/api/topics/latest.json", params: [:], success: { (data) in
            if data is NSArray {
                success(data as? NSArray)
            } else {
                failture(nil)
            }
        }) { (error) in
            failture(error)
        }
    }

    func fetchTopicReplies(params: [String: AnyObject], success: @escaping (_ responseObject: NSArray?) -> (), failture: @escaping (_ error: NSError?) -> ()) {
        self.getRequestWithoutCache(path: "/api/replies/show.json", params: params, success: { (data) in
            if data is NSArray {
                success(data as? NSArray)
            } else {
                failture(nil)
            }
        }) { (error) in
            failture(error)
        }
    }
}
