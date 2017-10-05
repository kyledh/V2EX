//
//  KDNodesVIewModel.swift
//  v2ex
//
//  Created by donghao on 2017/10/4.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDNodesVIewModel {
    
    var nodes = [KDNodeModel]()
    
    func fetchHotNodes(success: @escaping (_ responseObject: [KDNodeModel]) -> (), failture: @escaping (_ error: NSError?) -> ()) {
        KDAPIClient.sharedClient.fetchHotNodes(success: { (data) in
            self.nodes = [KDNodeModel].deserialize(from: data) as! [KDNodeModel]
            success(self.nodes)
        }) { (error) in
            failture(error)
        }
    }
}
