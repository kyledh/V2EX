//
//  KDUserParse.swift
//  v2ex
//
//  Created by donghao on 2018/1/6.
//  Copyright © 2018年 kyle. All rights reserved.
//

import UIKit

extension KDParseUtils {

    func verificationCode(_ data: Data) -> String? {
        guard let doc = DataConvertHTMLDocument(data) else { return nil }
        let text = doc.xpath("//*[@id=\"Main\"]/div[2]/div[2]/form/table//tr[3]/td[2]/div[1]").first?["style"] ?? ""
        let range = text.range(of: "/_\\S*\\d", options: .regularExpression, range: text.startIndex..<text.endIndex, locale:Locale.current)
        let code = String(text[range!])
        return code
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
