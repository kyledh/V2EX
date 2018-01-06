//
//  KDBaseViewController.swift
//  v2ex
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let dismissViewController = #selector(KDBaseViewController.dismissViewController)
}

class KDBaseViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.black
        presentLeftBar()
    }
    
    func setNavigationBarTransparent(_ bool: Bool) {
        if bool {
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationController?.navigationBar.shadowImage = UIImage()
        } else {
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            navigationController?.navigationBar.shadowImage = nil
        }
    }

    // MARK: Private Method
    private func presentLeftBar() {
        if presentingViewController != nil && navigationController?.viewControllers.count == 1 {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: .dismissViewController)
        }
    }
    
    @objc fileprivate func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
