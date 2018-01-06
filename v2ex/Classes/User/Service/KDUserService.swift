//
//  KDUserService.swift
//  v2ex
//
//  Created by donghao on 2017/11/11.
//  Copyright © 2017年 kyle. All rights reserved.
//

import Foundation

extension KDAPIClient {

    func fetchLoginPageInfo(success: SuccessClosure?, failure: FailureClosure?) {
        let path = "/signin"
        getRequest(path: path, params: nil, success: { (data) in
            success?(data)
        }) { error in
            failure?(error)
        }
    }
    
    func fetchUserDetail(username: String, success: SuccessClosure?, failure: FailureClosure?) {
        let path = "/member/\(username)"
        getRequest(path: path, params: nil, success: { (data) in
            success?(data)
        }) { (error) in
            failure?(error)
        }
    }
}
