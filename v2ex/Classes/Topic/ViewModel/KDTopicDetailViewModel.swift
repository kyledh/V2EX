//
//  KDTopicDetailViewModel.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDTopicDetailViewModel {
    
    var topic = KDTopicModel()
    var topicReplies = [KDReplyModel]()

    func fetchTopicDetail(topicUrl: String, success: @escaping (_ responseObject: KDTopicModel) -> (), failture: @escaping (_ error: NSError?) -> ()) {
        KDAPIClient.sharedClient.fetchTopicDetail(topicUrl: topicUrl, success: { [weak self] (data) in
            self?.topic.content = KDParseUtils.sharedParse.topicDetail(data!)
            self?.topicReplies = KDParseUtils.sharedParse.topicReplies(data!)
            success((self?.topic)!)
        }) { (error) in
            failture(error)
        }
    }
    
}
