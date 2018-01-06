//
//  KDParseUtils.swift
//  v2ex
//
//  Created by donghao on 2017/11/5.
//  Copyright © 2017年 kyle. All rights reserved.
//

import Fuzi

class KDParseUtils {
    
    public static let shared = KDParseUtils()
    
    public func DataConvertHTMLDocument(_ data: Data) -> HTMLDocument? {
        guard let string = String(data: data, encoding: .utf8) else { return nil }
        return StringConvertHTMLDocument(string)
    }
    
    public func StringConvertHTMLDocument(_ string: String) -> HTMLDocument? {
        do {
            let document = try HTMLDocument(string: string, encoding: .utf8)
            return document
        } catch {
            return nil
        }
    }
}

