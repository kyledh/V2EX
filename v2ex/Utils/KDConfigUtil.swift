//
//  KDConfigUtil.swift
//  qducc
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import Foundation

class KDConfigUtil {
    
    class func APIHost() -> String {
        let host: String = "https://www.v2ex.com"
        return host
    }

    class func setUserToken(token: String) {
        if !token.isEmpty {
            UserDefaults.standard.set(token, forKey: "token")
        }
    }
    
    class func userToken() -> String {
        let token = UserDefaults.standard.object(forKey: "token")
        if token != nil {
            return token as! String
        }
        return ""
    }
}
