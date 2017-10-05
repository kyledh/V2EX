//
//  KDNodeModel.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import HandyJSON

class KDNodeModel : HandyJSON {
    
    var avatarLarge: String?
    var avatarMini: String?
    var avatarNormal: String?
    var id: Int?
    var name: String?
    var title: String?
    var titleAlternative: String?
    var topics: Int?
    var url: String?

    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            avatarLarge <-- "avatar_large"
        mapper <<<
            avatarMini <-- "avatar_mini"
        mapper <<<
            avatarNormal <-- "avatar_normal"
        mapper <<<
            titleAlternative <-- "title_alternative"
    }
}
