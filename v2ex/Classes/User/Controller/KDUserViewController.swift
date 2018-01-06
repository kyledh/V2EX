//
//  KDUserViewController.swift
//  v2ex
//
//  Created by donghao on 2018/1/6.
//  Copyright © 2018年 kyle. All rights reserved.
//

import UIKit
import MBProgressHUD

class KDUserViewController: KDBaseViewController {
    
    public var username: String?
    
    private let viewModel = KDUserViewModel()
    private var userDetail: KDUserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = username
        loadData()
    }
    
    private func loadData() {
        guard username != nil else { return }
        MBProgressHUD.showAdded(to: view, animated: true)
        viewModel.fetchUserDetail(username: username!, success: { [weak self] data in
            guard let strongSelf = self else { return }
            strongSelf.userDetail = data
            strongSelf.refreshView()
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
        }) { [weak self] (error) in
            guard let strongSelf = self else { return }
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
        }
    }
    
    private func refreshView() {
        let url = URL(string: "https:" + (userDetail?.avatarLarge ?? ""))
        avatarImageView.kf.setImage(with: url)
        usernameLabel.text = userDetail?.username
        userBioLabel.text = userDetail?.userBio
        userInfoLabel.text = (userDetail?.userInfo ?? "") + (userDetail?.dauRank ?? "")
    }
    
    private func setupView() {
        view.addSubview(contentView)
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(userBioLabel)
        view.addSubview(userInfoLabel)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.top.equalTo(contentView).offset(10)
            make.width.height.equalTo(50)
        }
        usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.top.equalTo(avatarImageView)
        }
        userBioLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.right.equalTo(contentView).offset(-15)
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
        }
        userInfoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(-15)
            make.top.greaterThanOrEqualTo(userBioLabel.snp.bottom).offset(10)
            make.top.greaterThanOrEqualTo(avatarImageView.snp.bottom).offset(10)
        }
    }
    
    private lazy var contentView: UIScrollView = {
        var scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var avatarImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        if #available(iOS 11, *) {
            imageView.accessibilityIgnoresInvertColors = true
        }
        return imageView
    }()
    
    private lazy var usernameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.hex("778087")
        return label
    }()
    
    private lazy var userBioLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var userInfoLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex("999999")
        label.numberOfLines = 0
        return label
    }()
}
