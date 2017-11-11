//
//  KDUserViewController.swift
//  v2ex
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDUserViewController : KDBaseLargeTitlesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "个人"
        setupView()
    }
    
    // MARK: Private Method
    private func setupView() {
        let rightBarItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "kd_setting"), style: .plain, target: self, action: #selector(jumpSettingViewController))
        navigationItem.rightBarButtonItem = rightBarItem;
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }
    }
    
    @objc private func jumpSettingViewController() {
        let settingViewController = KDSettingViewController()
        settingViewController.hidesBottomBarWhenPushed = true;
        navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    @objc private func jumpLoginViewController() {
        let loginViewController = UINavigationController.init(rootViewController: KDLoginViewController())
        present(loginViewController, animated: true, completion: nil)
    }
    
    // MARK: Lazy Loading
    private lazy var loginButton: UIButton = {
        var button = UIButton()
        button.setTitle("  前往登录  ", for: .normal)
        button.setTitleColor(UIColor.HEXCOLOR("555566"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.HEXCOLOR("555566").cgColor
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(jumpLoginViewController), for: .touchUpInside)
        return button
    }()
}
