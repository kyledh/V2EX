//
//  KDReplyCell.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

private extension Selector {
    static let clickAvatarEvent = #selector(KDReplyCell.clickAvatarEvent)
}

class KDReplyCell : UITableViewCell {
    
    public var clickAvatar: ((_ username: String) -> Void)? = nil

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    // FIXME: 不合理，应该使用 Struts
    func loadData(_ model: KDReplyModel) {
        let url = URL(string: "https:" + (model.createdAvatar)!)
        avatarButton.kf.setImage(with: url, for: .normal)
        creatorLabel.text = model.createdName
//        timeLabel.text = model.created?.formatDate()
//        tagLabel.text = model.tag
        contentLabel.text = model.content
        floorLabel.text = " \(model.floor ?? "0") "
        layoutIfNeeded()
    }
    
    private func setupView() {
        contentView.topLine()
        contentView.addSubview(avatarButton)
        contentView.addSubview(creatorLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(tagLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(floorLabel)
        avatarButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(15)
            make.width.height.equalTo(30)
        }
        creatorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(avatarButton.snp.right).offset(10)
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
            make.left.equalTo(avatarButton.snp.right).offset(10)
            make.right.equalTo(contentView).offset(-15)
            make.bottom.equalTo(contentView).offset(-10)
        }
        floorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-15)
        }
    }
    
    @objc fileprivate func clickAvatarEvent() {
        guard let username = creatorLabel.text else { return }
        clickAvatar?(username)
    }
    
    // MARK: Lazy Loading
    private lazy var avatarButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .gray
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        if #available(iOS 11, *) {
            button.accessibilityIgnoresInvertColors = true
        }
        button.addTarget(self, action: .clickAvatarEvent, for: .touchUpInside)
        return button
    }()
    
    private lazy var creatorLabel: UILabel = {
       var label = UILabel()
        label.textColor = UIColor.hex("778087")
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.hex("cccccc")
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var tagLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.hex("778087")
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
       var label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var floorLabel: UILabel = {
       var label = UILabel()
        label.textColor = UIColor.hex("cccccc")
        label.backgroundColor = UIColor.hex("f0f0f0")
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        return label
    }()
}
