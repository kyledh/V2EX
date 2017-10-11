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
        title = "个人";
        setupView()
    }
    
    // MARK: Private Method
    private func setupView() {
        let rightBarItem = UIBarButtonItem.init(image: UIImage.init(named: "kd_setting"), style: .plain, target: self, action: #selector(jumpSettingViewController))
        navigationItem.rightBarButtonItem = rightBarItem;
    }
    
    @objc private func jumpSettingViewController() {
    }
}
