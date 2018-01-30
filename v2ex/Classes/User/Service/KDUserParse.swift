//
//  KDUserParse.swift
//  v2ex
//
//  Created by donghao on 2018/1/6.
//  Copyright © 2018年 kyle. All rights reserved.
//

import UIKit

extension KDParseUtils {

    func loginParams(_ data: Data) -> KDLoginModel? {
        guard let doc = DataConvertHTMLDocument(data) else { return nil }
        let params = KDLoginModel()
        let infos = doc.xpath("//*[@id=\"Main\"]/div[2]/div[2]/form/table").first
        let username = infos?.xpath("//tr[1]/td[2]/input").first
        let password = infos?.xpath("//tr[2]/td[2]/input").first
        let code = infos?.xpath("//tr[3]/td[2]/input").first
        let codeUrl = infos?.xpath("tr[3]/td[2]/div[1]").first?["style"] ?? ""
        let range = codeUrl.range(of: "/_\\S*\\d", options: .regularExpression, range: codeUrl.startIndex..<codeUrl.endIndex, locale:Locale.current)
        params.usernameKey = username?["name"]
        params.passwordKey = password?["name"]
        params.codeKey = code?["name"]
        params.codeUrl = String(codeUrl[range!])
        return params
    }
    
    func userDetail(_ data: Data) -> KDUserModel? {
        guard let doc = DataConvertHTMLDocument(data) else { return nil }
        guard let detail = doc.xpath("//*[@id=\"Main\"]/div[2]/div[1]/table//tr").first else { return nil }
        let model = KDUserModel()
        model.avatarLarge = detail.xpath("td[1]/img").first?["src"]
        model.username = detail.xpath("td[3]/h1").first?.stringValue
        model.userBio = detail.xpath("td[3]/span[@class=\"bigger\"]/text()").first?.stringValue
        model.userInfo = detail.xpath("td[3]/span[@class=\"gray\"]/text()").first?.stringValue.trimmingCharacters(in: .whitespaces)
        model.dauRank = detail.xpath("td[3]/span[@class=\"gray\"]/a").first?.stringValue
        model.status = detail.xpath("td[1]/strong").first?.stringValue
        return model
    }

}
