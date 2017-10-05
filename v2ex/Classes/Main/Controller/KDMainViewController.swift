//
//  KDMainViewController.swift
//  qducc
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDMainViewController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.black
        
        let homeNavigationController = UINavigationController.init(rootViewController: KDHomeViewController())
        let userNavigationController = UINavigationController.init(rootViewController: KDUserViewController())
        
        homeNavigationController.tabBarItem.title = "首页"
        homeNavigationController.tabBarItem.image = UIImage.init(imageLiteralResourceName: "kd_home")
        userNavigationController.tabBarItem.title = "个人"
        userNavigationController.tabBarItem.image = UIImage.init(imageLiteralResourceName: "kd_user")
        
        viewControllers = [homeNavigationController,
                                userNavigationController]
    }
    
}
