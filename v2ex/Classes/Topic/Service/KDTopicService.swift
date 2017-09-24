//
//  KDTopicService.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

extension KDAPIClient {

    func getTopicsLatest(success: @escaping (_ responseObject: NSArray) -> (), failture: @escaping (_ error: NSError) -> ()) {
        self.getRequest(path: "/api/topics/latest.json", params: [:], success: { (data) in
            if data is NSArray {
                success((data as? NSArray)!)
            }
        }) { (error) in
            failture(error)
        }
    }
}
