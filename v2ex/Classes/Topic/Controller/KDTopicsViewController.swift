//
//  KDTopicsViewController.swift
//  v2ex
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDTopicsViewController: KDBaseViewController {
    
    var viewModel = KDTopicsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_setupView()
        p_loadData()
    }
    
    // MARK: Private Method
    private func p_setupView() {
        view.addSubview(tableView)
        tableView .snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    private func p_loadData() {
        viewModel.fetchTopicLatest(success: { (data) in
            self.tableView.reloadData()
        }) { (error) in
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
}

// MARK: UITableViewDelegate
extension KDTopicsViewController: UITableViewDelegate {
    
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
extension KDTopicsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.topics.count;
    }
}
