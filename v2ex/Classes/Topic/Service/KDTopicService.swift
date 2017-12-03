//
//  KDTopicService.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import Foundation

extension KDAPIClient {

    public func fetchTopicsWithNode(nodeName: String,
                                    success: SuccessClosure?,
                                    failure: FailureClosure?) {
        let params = ["tab": nodeName as AnyObject]
        self.getRequest(path: nil,
                        params: params,
                        success: { (data) in
                            success?(data)
        },
                        failure: { (error) in
                            failure?(error)
        })
    }

    public func fetchTopicDetail(topicUrl: String,
                                 success: SuccessClosure?,
                                 failure: FailureClosure?)
    {
        self.getRequest(path: topicUrl,
                        params: nil,
                        success: { data in
                            success?(data)
        },
                        failure: { error in
                            failure?(error)
        })
    }
}
