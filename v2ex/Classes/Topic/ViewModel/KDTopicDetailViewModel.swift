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

//    func fetchTopicReplies(params: [String: AnyObject], success: @escaping (_ responseObject: [KDReplyModel]) -> (), failture: @escaping (_ error: NSError?) -> ()) {
//        KDAPIClient.sharedClient.fetchTopicReplies(params: params, success: { (data) in
//            self.topicReplies = [KDReplyModel].deserialize(from: data) as! [KDReplyModel]
//            self.topicReplies.forEach({ (reply) in
//                if self.topic.member?.id == reply.member?.id {
//                    reply.tag = "楼主"
//                }
//            })
//            success(self.topicReplies)
//        }) { (error) in
//            failture(error)
//        }
//    }
    
}
