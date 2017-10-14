//
//  KDTopicsViewController.swift
//  v2ex
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDTopicsViewController : KDBaseViewController {
    
    var viewModel = KDTopicsViewModel()
    var nodeName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        refreshData()
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
    }
    
    @objc func refreshData() {
        viewModel.fetchTopicsWithNode(nodeName: nodeName!, success: { (data) in
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }) { (error) in
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: Private Method
    private func setupView() {
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    // MARK: Lazy Loading
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(KDTopicCell.classForCoder(), forCellReuseIdentifier: "kd_topic_cell")
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        return refreshControl
    }()
}

// MARK: UITableViewDelegate
extension KDTopicsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < viewModel.topics.count {
            let model = viewModel.topics[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "kd_topic_cell") as! KDTopicCell
            cell.loadData(model)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < viewModel.topics.count {
            let topicModel = viewModel.topics[indexPath.row]
            let topicDetailViewController = KDTopicDetailViewController()
            topicDetailViewController.viewModel.topic = topicModel
            topicDetailViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(topicDetailViewController, animated: true)
        }
    }
}

// MARK: UITableViewDataSource
extension KDTopicsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.topics.count;
    }
}

// MARK: UIViewControllerPreviewingDelegate
extension KDTopicsViewController : UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        var point = location
        point.y += tableView.contentOffset.y
        if tableView.layer.contains(point) {
            let indexPath = tableView.indexPathForRow(at: point)!
            if indexPath.row < viewModel.topics.count {
                let cell = tableView .cellForRow(at: indexPath)
                var sourceRect = cell?.frame
                sourceRect?.origin.y -= tableView.contentOffset.y
                previewingContext.sourceRect = sourceRect ?? CGRect.zero
                let topicDetailViewController = KDTopicDetailViewController()
                topicDetailViewController.viewModel.topic = viewModel.topics[indexPath.row]
                topicDetailViewController.hidesBottomBarWhenPushed = true
                return topicDetailViewController
            }
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: false)
    }
}
