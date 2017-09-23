//
//  KDMainViewController.swift
//  qducc
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDMainViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = KDUIKitUtil.HEXCOLOR("000000")
        
        let homeNavigationController = UINavigationController.init(rootViewController: KDHomeViewController())
        let userNavigationController = UINavigationController.init(rootViewController: KDUserViewController())
        
        homeNavigationController.tabBarItem.title = "首页"
        homeNavigationController.tabBarItem.image = UIImage.init(imageLiteralResourceName: "kd_home")
        userNavigationController.tabBarItem.title = "个人"
        userNavigationController.tabBarItem.image = UIImage.init(imageLiteralResourceName: "kd_user")
        
        self.viewControllers = [homeNavigationController,
                                userNavigationController]
    }
    
}
