//
//  KDTopicCell.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

import Kingfisher

class KDTopicCell : UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    // FIXME: 不合理，应该使用 Struts
    func loadData(_ model: KDTopicModel) {
        let url = URL(string: "https:" + (model.createdAvatar)!)
        avatorImageView.kf.setImage(with: url)
        titleLabel.text = model.title
        nodeLabel.text = " \(model.nodeName ?? "") "
        creatorLabel.text = model.createdName
        repliesLabel.text = " \(model.repliesCount ?? "0") "
        layoutIfNeeded()
    }
    
    // MARK: Private Method
    private func setupView() {
        contentView.bottomLine()
        contentView.addSubview(avatorImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nodeLabel)
        contentView.addSubview(creatorLabel)
        contentView.addSubview(repliesLabel)
        avatorImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.width.height.equalTo(35)
            make.centerY.equalTo(contentView)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(avatorImageView.snp.right).offset(10)
            make.right.lessThanOrEqualTo(repliesLabel.snp.left).offset(-10)
        }
        nodeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(avatorImageView.snp.right).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
        }
        creatorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(nodeLabel.snp.right).offset(10)
            make.right.lessThanOrEqualTo(repliesLabel.snp.left).offset(-10)
            make.bottom.equalTo(contentView).offset(-10)
        }
        repliesLabel.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-15)
            make.centerY.equalTo(contentView)
        }
    }
    
    // MARK: Lazy Loading
    private lazy var avatorImageView: UIImageView = {
        var avatorImageView = UIImageView()
        avatorImageView.layer.cornerRadius = 3
        avatorImageView.layer.masksToBounds = true
        return avatorImageView
    }()
    
    private lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.textColor = UIColor.HEXCOLOR("778087")
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private lazy var nodeLabel: UILabel = {
       var nodeLabel = UILabel()
        nodeLabel.textColor = UIColor.HEXCOLOR("999999")
        nodeLabel.font = UIFont.systemFont(ofSize: 12)
        nodeLabel.backgroundColor = UIColor.HEXCOLOR("f5f5f5")
        return nodeLabel
    }()
    
    private lazy var creatorLabel: UILabel = {
       var creatorLabel = UILabel()
        creatorLabel.textColor = UIColor.HEXCOLOR("778087")
        creatorLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return creatorLabel
    }()
    
    private lazy var repliesLabel: UILabel = {
       var repliesLabel = UILabel()
        repliesLabel.textColor = UIColor.white
        repliesLabel.backgroundColor = UIColor.HEXCOLOR("aab0c6")
        repliesLabel.font = UIFont.boldSystemFont(ofSize: 12)
        repliesLabel.layer.cornerRadius = 5
        repliesLabel.layer.masksToBounds = true
        repliesLabel.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        return repliesLabel
    }()
}
