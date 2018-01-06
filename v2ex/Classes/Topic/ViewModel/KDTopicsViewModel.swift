//
//  KDTopicsViewModel.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import Foundation

class KDTopicsViewModel {
    
    var topics = [KDTopicModel]()

    func fetchTopicsWithNode(nodeName: String, success: ((_ topics: [KDTopicModel]) -> ())?, failure: FailureClosure?) {
        KDAPIClient.shared.fetchTopicsWithNode(nodeName: nodeName, success: { [weak self] data in
            guard let strongSelf = self else { return }
            guard data != nil else {
                failure?(nil)
                return
            }
            strongSelf.topics = KDParseUtils.shared.topics(data!) ?? []
            success?(strongSelf.topics)
            }, failure: { (error) in
                failure?(error)
        })
    }
}
