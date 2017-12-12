//
//  KDLoginViewModel.swift
//  v2ex
//
//  Created by donghao on 2017/11/12.
//  Copyright © 2017年 kyle. All rights reserved.
//

import Foundation

class KDLoginViewModel {

    func fetchVerificationCode(success: ((_ codeURL: String) -> ())?, failure: FailureClosure?) {
        KDAPIClient.shared.fetchLoginPageInfo(success: { data in
            guard let _ = data else { return }
            guard let codeURL = KDParseUtils.shared.verificationCode(data!) else {
                failure?(nil)
                return
            }
            success?(codeURL)
        }, failure: { error in
            failure?(error)
        })
    }
}
