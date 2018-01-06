//
//  KDTopicsViewController.swift
//  v2ex
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit
import MBProgressHUD
import Then

fileprivate extension Selector {
    static let refreshData = #selector(KDTopicsViewController.refreshData)
}

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

    @objc fileprivate func refreshData() {
        MBProgressHUD.showAdded(to: view, animated: true)
        viewModel.fetchTopicsWithNode(nodeName: nodeName!, success: { [weak self] data in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
            strongSelf.refreshControl.endRefreshing()
        }) { [weak self] error in
            guard let strongSelf = self else { return }
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
            strongSelf.refreshControl.endRefreshing()
        }
    }
    
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
        tableView.separatorStyle = .none
        tableView.register(KDTopicCell.classForCoder(), forCellReuseIdentifier: "kd_topic_cell")
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: .refreshData, for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        return refreshControl
    }()
}

// MARK: UITableViewDelegate
extension KDTopicsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "kd_topic_cell") as? KDTopicCell else {
            return UITableViewCell()
        }
        let model = viewModel.topics[indexPath.row]
        cell.loadData(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let topicModel = viewModel.topics[indexPath.row]
        let topicDetailViewController = KDTopicDetailViewController().then {
            $0.topic = topicModel
            $0.hidesBottomBarWhenPushed = true
        }
        navigationController?.pushViewController(topicDetailViewController, animated: true)
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
        
        guard tableView.layer.contains(point) else { return nil }
        guard let indexPath = tableView.indexPathForRow(at: point) else { return nil }
        guard indexPath.row < viewModel.topics.count else { return nil }
        
        guard var sourceRect = tableView .cellForRow(at: indexPath)?.frame else { return nil }
        sourceRect.origin.y -= tableView.contentOffset.y
        previewingContext.sourceRect = sourceRect
        let topicDetailViewController = KDTopicDetailViewController().then {
            $0.topic = viewModel.topics[indexPath.row]
            $0.hidesBottomBarWhenPushed = true
        }
        return topicDetailViewController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: false)
    }
}
