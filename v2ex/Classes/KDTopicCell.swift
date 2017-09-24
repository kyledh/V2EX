//
//  KDTopicCell.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDTopicCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        p_setupView()
    }
    
    func loadData(_ title: String, _ node: String, _ creator: String) {
        titleLabel.text = title
        nodeLabel.text = node
        creatorLabel.text = creator
        layoutIfNeeded()
    }
    
    // MARK: Private Method
    private func p_setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(nodeLabel)
        contentView.addSubview(creatorLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(15)
            make.right.lessThanOrEqualTo(contentView).offset(-15)
        }
        nodeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(contentView).offset(15)
            make.bottom.equalTo(contentView).offset(-10)
        }
        creatorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(nodeLabel.snp.right).offset(10)
            make.right.lessThanOrEqualTo(contentView).offset(15)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
    
    // MARK: Lazy Loading
    private lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.textColor = KDUIKitUtil.HEXCOLOR("778087")
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private lazy var nodeLabel: UILabel = {
       var nodeLabel = UILabel()
        nodeLabel.textColor = KDUIKitUtil.HEXCOLOR("999999")
        nodeLabel.font = UIFont.systemFont(ofSize: 10)
        nodeLabel.backgroundColor = KDUIKitUtil.HEXCOLOR("f5f5f5")
        return nodeLabel
    }()
    
    private lazy var creatorLabel: UILabel = {
       var creatorLabel = UILabel()
        creatorLabel.textColor = KDUIKitUtil.HEXCOLOR("778087")
        creatorLabel.font = UIFont.systemFont(ofSize: 10)
        return creatorLabel
    }()
}
