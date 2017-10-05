//
//  KDReplyModel.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import HandyJSON

class KDReplyModel : HandyJSON {

    var content: String?
    var contentRendered: String?
    var created: Int?
    var id: Int?
    var lastModified: Int?
    var member: KDMemberModel?
    var thanks: Int?
    var floor: Int?
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            contentRendered <-- "content_rendered"
        mapper <<<
            lastModified <-- "last_modified"
    }
}
