//
//  KDHomeViewController.swift
//  v2ex
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

import SnapKit

class KDHomeViewController : KDBaseViewController {
    
    var viewControllers = [KDTopicsViewController]()
    var viewModel = KDNodesVIewModel()
    var indexOfTransitionTo: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页";
        setupView()
        reloadData()
    }
    
    // MARK: Private Method
    private func setupView() {
        addChildViewController(pageViewController)
        view.addSubview(slideTapView)
        view.addSubview(separateLine)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
        slideTapView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.height.equalTo(30)
        }
        separateLine.snp.makeConstraints { (make) in
            make.top.equalTo(slideTapView.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(0.5)
        }
        pageViewController.view.snp.makeConstraints { (make) in
            make.top.equalTo(separateLine.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    private func reloadData() {
        viewModel.fetchHotNodes(success: { (nodes) in
            self.slideTapView.reloadData()
            self.setViewControllers()
        }) { (error) in
        }
    }
    
    private func setViewControllers() {
        for node in viewModel.nodes {
            let controller = KDTopicsViewController()
            controller.nodeName = node.name
            viewControllers.append(controller)
        }
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    
    // MARK: Lazy Loading
    private lazy var pageViewController: UIPageViewController = {
        var pageViewController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        return pageViewController
    }()
    
    private lazy var slideTapView: KDSlideTapView = {
        let slideTapView = KDSlideTapView()
        slideTapView.slideTapDelegate = self
        return slideTapView
    }()
    
    private lazy var separateLine: UIView = {
        let separateLine = UIView()
        separateLine.backgroundColor = UIColor.HEXCOLOR("e2e2e2")
        return separateLine
    }()
}

// MARK: UIPageViewControllerDelegate
extension KDHomeViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished && completed {
            slideTapView.currentIndex = indexOfTransitionTo
        } else {
            let controller = previousViewControllers.first as! KDTopicsViewController
            indexOfTransitionTo = viewControllers.index(of: controller)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let controller = pendingViewControllers.first as! KDTopicsViewController
        indexOfTransitionTo = viewControllers.index(of: controller)
    }
}

// MARK: UIPageViewControllerDataSource
extension KDHomeViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let controller = viewController as! KDTopicsViewController
        var index = viewControllers.index(of: controller)
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
        let controller = viewController as! KDTopicsViewController
        var index = viewControllers.index(of: controller)
        if index == NSNotFound {
            return nil;
        }
        index = index! + 1
        if index! >= 0 && index! < viewControllers.count {
            return viewControllers[index!]
        }
        return nil
    }
}

// MARK: KDSlideTapView
extension KDHomeViewController : KDSlideTapDelegate {
    
    func slideTapViewNumberOfRows(_ slideTapView: KDSlideTapView) -> Int {
        return viewModel.nodes.count
    }
    
    func slideTapView(_ slideTapView: KDSlideTapView, titleAtIndex index: Int) -> String {
        return viewModel.nodes[index].title ?? ""
    }
    
    func slideTapView(in slideTapView: KDSlideTapView, didSelectAtIndex index: Int) {
        let direction: UIPageViewControllerNavigationDirection?
        if index > slideTapView.currentIndex {
            direction = .forward
        } else {
            direction = .reverse
        }
        pageViewController.setViewControllers([viewControllers[index]], direction: direction!, animated: true, completion: nil)
    }
}
