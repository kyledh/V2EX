//
//  KDLoginViewModel.swift
//  v2ex
//
//  Created by donghao on 2017/11/12.
//  Copyright © 2017年 kyle. All rights reserved.
//

import Foundation

class KDLoginViewModel {
    
    func fetchVerificationCode(success: ((_ loginParams: KDLoginModel) -> ())?, failure: FailureClosure?) {
        KDAPIClient.shared.fetchLoginPageInfo(success: { data in
            guard data != nil else { return }
            guard let params = KDParseUtils.shared.loginParams(data!) else {
                failure?(nil)
                return
            }
            success?(params)
        }, failure: { error in
            failure?(error)
        })
    }
    
    func loginV2ex(params: [String: Any], success: (() -> ())?, failure: FailureClosure?) {
        KDAPIClient.shared.loginV2ex(params: params, success: { data in
            guard data != nil else { return }
            success?()
        }, failure: { error in
            failure?(error)
        })
    }
}
