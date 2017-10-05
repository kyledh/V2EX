//
//  KDResources.swift
//  v2ex
//
//  Created by donghao on 2017/10/4.
//  Copyright © 2017年 kyle. All rights reserved.
//

import Foundation

class KDResources {
    
    class func topicHTML(_ content: String) -> String {
        let resources = KDResources()
        var topicHTML = try! String(contentsOfFile: Bundle.main.path(forResource: "topic", ofType: "html")!, encoding: .utf8)
        let topicCSS = resources.basicCSS() + resources.mobileCSS()
        topicHTML = topicHTML.replacingOccurrences(of: "CONTENT_CSS", with: topicCSS)
        topicHTML = topicHTML.replacingOccurrences(of: "CONTENT_BODY", with: content)
        return topicHTML
    }
    
    private func basicCSS() -> String {
        let basicCSS = try! String(contentsOfFile: Bundle.main.path(forResource: "basic", ofType: "css")!, encoding: .utf8)
        return basicCSS;
    }
    
    private func mobileCSS() -> String {
        let mobileCSS = try! String(contentsOfFile: Bundle.main.path(forResource: "style", ofType: "css")!, encoding: .utf8)
        return mobileCSS;
    }
}
