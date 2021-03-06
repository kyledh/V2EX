//
//  KDTopicParse.swift
//  v2ex
//
//  Created by donghao on 2017/11/5.
//  Copyright © 2017年 kyle. All rights reserved.
//

import Fuzi

extension KDParseUtils {

    func topics(_ data: Data) -> [KDTopicModel]? {
        guard let doc = DataConvertHTMLDocument(data) else { return nil }
        let cells = doc.xpath("//*[@id=\"Main\"]/div[2]/div[@class=\"cell item\"]")
        var items = [KDTopicModel]()
        for div in cells {
            let tds = div.xpath("table/tr/td")
            let topic = KDTopicModel()
            topic.title = tds[2].xpath("span[@class=\"item_title\"]/a").first?.stringValue
            topic.url = tds[2].xpath("span[@class=\"item_title\"]/a").first?["href"]
            topic.node = tds[2].xpath("span/a[@class=\"node\"]").first?["href"]
            topic.nodeName = tds[2].xpath("span/a[@class=\"node\"]").first?.stringValue
            topic.createdName = tds[2].xpath("span/strong").first?.stringValue
            topic.createdAvatar = tds[0].xpath("a/img").first?["src"]
            topic.repliesCount = tds[3].xpath("a[@class=\"count_livid\"]").first?.stringValue
            items.append(topic)
        }
        return items
    }
    
    func topicDetail(_ data: Data) -> String? {
        guard let doc = DataConvertHTMLDocument(data) else { return nil }
        let content = doc.xpath("//*[@id=\"Main\"]/div[2]/div[2]/div").first?.rawXML
        return content
    }
    
    func topicReplies(_ data: Data) -> [KDReplyModel]? {
        guard let doc = DataConvertHTMLDocument(data) else { return nil }
        let cells = doc.xpath("//*[@id=\"Main\"]/div[4]/div/table");
        var items = [KDReplyModel]();
        for div in cells {
            let tds = div.xpath("tr/td");
            // TODO:分页处理
            if tds.count < 3 {
                continue;
            }
            let reply = KDReplyModel()
            reply.createdName = tds[2].xpath("strong/a").first?.stringValue
            reply.createdAvatar = tds[0].xpath("img").first?["src"]
            reply.content = tds[2].xpath("div[4]").first?.stringValue
            reply.floor = tds[2].xpath("div[1]/span[@class=\"no\"]").first?.stringValue
            items.append(reply)
        }
        return items
    }
}
