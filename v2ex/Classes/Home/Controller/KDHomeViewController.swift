//
//  KDHomeViewController.swift
//  v2ex
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

import SnapKit

class KDHomeViewController: KDBaseViewController {
    
    var viewControllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页";
        p_setViewControllers()
        p_setupView()
    }
    
    // MARK: Private Method
    private func p_setupView() {
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
        pageViewController.view.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    private func p_setViewControllers() {
        viewControllers.append(KDPostListViewController())
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    
    // MARK: Lazy Loading
    private lazy var pageViewController: UIPageViewController = {
        var pageViewController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        return pageViewController
    }()
}

// MARK: UIPageViewControllerDelegate
extension KDHomeViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    }
}

// MARK: UIPageViewControllerDataSource
extension KDHomeViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = viewControllers.index(of: viewController)
        if index == NSNotFound {
            return nil;
        }
        index = index! - 1
        if index! >= 0 && index! < viewControllers.count {
            return viewControllers[index!]
        }
        return nil;
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = viewControllers.index(of: viewController)
        if index == NSNotFound {
            return nil;
        }
        index = index! + 1
        if index! >= 0 && index! < viewControllers.count {
            return viewControllers[index!]
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllers.count
    }
}
