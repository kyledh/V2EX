//
//  KDParseUtils.swift
//  v2ex
//
//  Created by donghao on 2017/11/5.
//  Copyright © 2017年 kyle. All rights reserved.
//

import Fuzi

class KDParseUtils {
    
    static let sharedParse: KDParseUtils = {
        let parse = KDParseUtils()
        return parse
    }()
}