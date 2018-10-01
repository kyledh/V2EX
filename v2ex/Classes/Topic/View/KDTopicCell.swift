//
//  KDTopicCell.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import Kingfisher

private extension Selector {
    static let clickAvatarEvent = #selector(KDTopicCell.clickAvatarEvent)
}

class KDTopicCell : UITableViewCell {
    
    public var clickAvatar: ((_ username: String) -> Void)? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    // FIXME: 不合理，应该使用 Struts
    func loadData(_ model: KDTopicModel) {
        let url = URL(string: "https:" + (model.createdAvatar ?? ""))
        avatarButton.kf.setImage(with: url, for: .normal)
        titleLabel.text = model.title
        nodeLabel.text = " \(model.nodeName ?? "") "
        creatorLabel.text = model.createdName
        repliesLabel.text = " \(model.repliesCount ?? "0") "
        layoutIfNeeded()
    }
    
    private func setupView() {
        contentView.bottomLine()
        contentView.addSubview(avatarButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nodeLabel)
        contentView.addSubview(creatorLabel)
        contentView.addSubview(repliesLabel)
        avatarButton.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.width.height.equalTo(35)
            make.centerY.equalTo(contentView)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(avatarButton.snp.right).offset(10)
            make.right.lessThanOrEqualTo(repliesLabel.snp.left).offset(-10)
        }
        nodeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(avatarButton.snp.right).offset(10)
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
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.hex("778087")
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nodeLabel: UILabel = {
       var label = UILabel()
        label.textColor = UIColor.hex("999999")
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = UIColor.hex("f5f5f5")
        return label
    }()
    
    private lazy var creatorLabel: UILabel = {
       var label = UILabel()
        label.textColor = UIColor.hex("778087")
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var repliesLabel: UILabel = {
       var label = UILabel()
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.hex("aab0c6")
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        return label
    }()
}
