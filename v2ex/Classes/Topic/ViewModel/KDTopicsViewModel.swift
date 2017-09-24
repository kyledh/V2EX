//
//  KDTopicsViewModel.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDTopicsViewModel: NSObject {
    
    var topics = [KDTopicModel]()

    func getTopicLatest(success: @escaping (_ responseObject: [KDTopicModel]) -> (), failture: @escaping (_ error: NSError) -> ()) {
        KDAPIClient.sharedClient.getTopicsLatest(success: { (data) in
            self.topics = [KDTopicModel].deserialize(from: data) as! [KDTopicModel]
            success(self.topics )
        }) { (error) in
            failture(error)
        }
    }
}
