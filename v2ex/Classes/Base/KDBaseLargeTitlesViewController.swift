//
//  KDBaseLargeTitlesViewController.swift
//  v2ex
//
//  Created by donghao on 2017/10/11.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDBaseLargeTitlesViewController: KDBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
}
