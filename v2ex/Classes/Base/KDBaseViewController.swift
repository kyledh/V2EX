//
//  KDBaseViewController.swift
//  v2ex
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = KDUIKitUtil.HEXCOLOR("FAF7FF")
    }
    
    func setNavigationBarTransparent(_ bool: Bool) {
        if bool {
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        } else {
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = nil
        }
    }

}
