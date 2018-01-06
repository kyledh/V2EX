//
//  KDTopicDetailViewModel.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import Foundation

class KDTopicDetailViewModel {
    
    var topic = KDTopicModel()
    var topicReplies = [KDReplyModel]()

    func fetchTopicDetail(topicUrl: String, success: ((_ topic: KDTopicModel) -> ())?, failure: FailureClosure?) {
        KDAPIClient.shared.fetchTopicDetail(topicUrl: topicUrl, success: { [weak self] data in
            guard let strongSelf = self else { return }
            guard data != nil else {
                failure?(nil)
                return
            }
            strongSelf.topic.content = KDParseUtils.shared.topicDetail(data!) ?? ""
            strongSelf.topicReplies = KDParseUtils.shared.topicReplies(data!) ?? []
            success?(strongSelf.topic)
        }) { (error) in
            failure?(error)
        }
    }
    
}
