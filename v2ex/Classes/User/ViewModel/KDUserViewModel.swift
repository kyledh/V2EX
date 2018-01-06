//
//  KDUserViewModel.swift
//  v2ex
//
//  Created by donghao on 2018/1/6.
//  Copyright © 2018年 kyle. All rights reserved.
//

import UIKit

class KDUserViewModel {
    
    func fetchUserDetail(username: String, success: ((_ userDetail: KDUserModel) -> ())?, failure: FailureClosure?) {
        KDAPIClient.shared.fetchUserDetail(username: username, success: { data in
            guard data != nil else { return }
            let userDetail: KDUserModel = KDParseUtils.shared.userDetail(data!) ?? KDUserModel()
            success?(userDetail)
        }, failure: { error in
            failure?(error)
        })
    }
}
