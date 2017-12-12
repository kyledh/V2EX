//
//  KDLoginParse.swift
//  v2ex
//
//  Created by donghao on 2017/11/12.
//  Copyright © 2017年 kyle. All rights reserved.
//

import Fuzi

extension KDParseUtils {

    func verificationCode(_ data: Data) -> String? {
        guard let doc = DataConvertHTMLDocument(data) else { return nil }
        let text = doc.xpath("//*[@id=\"Main\"]/div[2]/div[2]/form/table//tr[3]/td[2]/div[1]").first?["style"] ?? ""
        let range = text.range(of: "/_\\S*\\d", options: .regularExpression, range: text.startIndex..<text.endIndex, locale:Locale.current)
        let code = String(text[range!])
        return code
    }
}
