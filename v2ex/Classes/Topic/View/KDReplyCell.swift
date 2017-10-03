//
//  KDReplyCell.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDReplyCell: UITableViewCell {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        p_setupView()
    }
    
    // FIXME: 不合理，应该使用 Struts
    func loadData(_ model: KDReplyModel) {
        let url = URL(string: "https:" + (model.member?.avatarMini)!)
        avatorImageView.kf.setImage(with: url)
        creatorLabel.text = model.member?.username
        timeLabel.text = model.created?.formatDate()
        contentLabel.text = model.content
        floorLabel.text = " \(model.floor ?? 0) "
        layoutIfNeeded()
    }
    
    // MARK: Private Method
    private func p_setupView() {
        contentView.topLine()
        contentView.addSubview(avatorImageView)
        contentView.addSubview(creatorLabel)
        contentView.addSubview(timeLabel)
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
        return avatorImageView
    }()
    
    private lazy var creatorLabel: UILabel = {
       var creatorLabel = UILabel()
        creatorLabel.textColor = KDUIKitUtil.HEXCOLOR("778087")
        creatorLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return creatorLabel
    }()
    
    private lazy var timeLabel: UILabel = {
        var timeLabel = UILabel()
        timeLabel.textColor = KDUIKitUtil.HEXCOLOR("cccccc")
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        return timeLabel
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
        floorLabel.textColor = KDUIKitUtil.HEXCOLOR("cccccc")
        floorLabel.backgroundColor = KDUIKitUtil.HEXCOLOR("f0f0f0")
        floorLabel.font = UIFont.boldSystemFont(ofSize: 12)
        floorLabel.layer.cornerRadius = 5
        floorLabel.layer.masksToBounds = true
        floorLabel.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        return floorLabel
    }()
}
