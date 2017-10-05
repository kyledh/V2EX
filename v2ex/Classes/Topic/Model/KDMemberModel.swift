//
//  KDMemberModel.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import HandyJSON

class KDMemberModel : HandyJSON {
    
    var avatarLarge: String?
    var avatarMini: String?
    var avatarNormal: String?
    var id: Int?
    var tagline: String?
    var username: String?
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            avatarLarge <-- "avatar_large"
        mapper <<<
            avatarMini <-- "avatar_mini"
        mapper <<<
            avatarNormal <-- "avatar_normal"
    }

    required init() {}
}
