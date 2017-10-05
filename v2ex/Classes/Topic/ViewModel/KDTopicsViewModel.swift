//
//  KDTopicsViewModel.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDTopicsViewModel {
    
    var topics = [KDTopicModel]()

    func fetchTopicsWithNode(nodeName: String, success: @escaping (_ responseObject: [KDTopicModel]) -> (), failture: @escaping (_ error: NSError?) -> ()) {
        KDAPIClient.sharedClient.fetchTopicsWithNode(nodeName: nodeName, success: { (data) in
            self.topics = [KDTopicModel].deserialize(from: data) as! [KDTopicModel]
            success(self.topics)
        }) { (error) in
            failture(error)
        }
    }
}
