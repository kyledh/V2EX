//
//  KDReplyCell.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDReplyCell : UITableViewCell {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    // FIXME: 不合理，应该使用 Struts
    func loadData(_ model: KDReplyModel) {
        let url = URL(string: "https:" + (model.createdAvatar)!)
        avatorImageView.kf.setImage(with: url)
        creatorLabel.text = model.createdName
//        timeLabel.text = model.created?.formatDate()
//        tagLabel.text = model.tag
        contentLabel.text = model.content
        floorLabel.text = " \(model.floor ?? "0") "
        layoutIfNeeded()
    }
    
    private func setupView() {
        contentView.topLine()
        contentView.addSubview(avatorImageView)
        contentView.addSubview(creatorLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(tagLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(floorLabel)
        avatorImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(15)
            make.width.height.equalTo(30)
        }
        creatorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(avatorImageView.snp.right).offset(10)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(creatorLabel.snp.right).offset(5)
            make.right.lessThanOrEqualTo(tagLabel.snp.left).offset(-10)
        }
        tagLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.right.lessThanOrEqualTo(floorLabel.snp.left).offset(-10)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(creatorLabel.snp.bottom).offset(5)
            make.left.equalTo(avatorImageView.snp.right).offset(10)
            make.right.equalTo(contentView).offset(-15)
            make.bottom.equalTo(contentView).offset(-10)
        }
        floorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-15)
        }
    }
    
    // MARK: Lazy Loading
    private lazy var avatorImageView: UIImageView = {
        var avatorImageView = UIImageView()
        avatorImageView.layer.cornerRadius = 3
        avatorImageView.layer.masksToBounds = true
        if #available(iOS 11, *) {
            avatorImageView.accessibilityIgnoresInvertColors = true
        }
        return avatorImageView
    }()
    
    private lazy var creatorLabel: UILabel = {
       var creatorLabel = UILabel()
        creatorLabel.textColor = UIColor.hex("778087")
        creatorLabel.font = UIFont.boldSystemFont(ofSize: 12)
        creatorLabel.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        return creatorLabel
    }()
    
    private lazy var timeLabel: UILabel = {
        var timeLabel = UILabel()
        timeLabel.textColor = UIColor.hex("cccccc")
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        return timeLabel
    }()
    
    private lazy var tagLabel: UILabel = {
        var tagLabel = UILabel()
        tagLabel.textColor = UIColor.hex("778087")
        tagLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return tagLabel
    }()
    
    private lazy var contentLabel: UILabel = {
       var contentLabel = UILabel()
        contentLabel.textColor = UIColor.black
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.numberOfLines = 0
        return contentLabel
    }()
    
    private lazy var floorLabel: UILabel = {
       var floorLabel = UILabel()
        floorLabel.textColor = UIColor.hex("cccccc")
        floorLabel.backgroundColor = UIColor.hex("f0f0f0")
        floorLabel.font = UIFont.boldSystemFont(ofSize: 12)
        floorLabel.layer.cornerRadius = 5
        floorLabel.layer.masksToBounds = true
        floorLabel.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        return floorLabel
    }()
}
