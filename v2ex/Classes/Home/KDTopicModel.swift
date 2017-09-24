//
//  KDTopicModel.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import HandyJSON

class KDTopicModel: HandyJSON {
    
    var content: String?
    var contentRendered: String?
    var created: Int?
    var id: Int?
    var lastModified: Int?
    var lastTouched: Int?
    var member: KDMemberModel?
    var node: KDNodeModel?
    var replies: Int?
    var title: String?
    var url: String?
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            contentRendered <-- "content_rendered"
        mapper <<<
            lastModified <-- "last_modified"
        mapper <<<
            lastTouched <-- "last_touched"
    }
    
    required init() {}
}
