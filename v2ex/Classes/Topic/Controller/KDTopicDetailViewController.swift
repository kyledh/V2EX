//
//  KDTopicDetailViewController.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class KDTopicDetailViewController: KDBaseViewController {
    
    var viewModel = KDTopicDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "主题详情"
        p_setupView()
        p_loadData()
    }
    
    // MARK: Private Method
    private func p_setupView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        p_setupTableHeader()
    }
    
    private func p_loadData() {
        let topic = viewModel.topic
        titleLabel.text = topic.title
        descriptionLabel.text = "By \(topic.member?.username ?? "") at \(topic.created?.formatDate() ?? "")"
        contentLabel.text = topic.content
        tableView.layoutIfNeeded()
        let params = ["topic_id": topic.id]
        viewModel.fetchTopicReplies(params: params as [String : AnyObject], success: { (data) in
            self.tableView.reloadData()
        }) { (error) in
        }
    }
    
    private func p_setupTableHeader() {
        tableView.tableHeaderView = tableHeaderView
        tableHeaderView.addSubview(titleLabel)
        tableHeaderView.addSubview(descriptionLabel)
        tableHeaderView.addSubview(contentLabel)
        tableHeaderView.snp.makeConstraints { (make) in
            make.width.equalTo(tableView.snp.width)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tableHeaderView).offset(10)
            make.left.equalTo(tableHeaderView).offset(15)
            make.right.equalTo(tableHeaderView).offset(-15)
        }
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(tableHeaderView).offset(15)
            make.right.equalTo(tableHeaderView).offset(-15)
            make.height.equalTo(25)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(tableHeaderView).offset(15)
            make.right.equalTo(tableHeaderView).offset(-15)
            make.bottom.equalTo(tableHeaderView).offset(-10)
        }
    }
    
    // MARK: Lazy Loading
    private lazy var tableHeaderView: UIView = {
        var tableHeaderView = UIView()
        return tableHeaderView
    }()
    
    private lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var descriptionLabel = UILabel()
        descriptionLabel.textColor = KDUIKitUtil.HEXCOLOR("999999")
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.bottomLine()
        return descriptionLabel
    }()
    
    private lazy var contentLabel: UILabel = {
        var contentLabel = UILabel()
        contentLabel.textColor = UIColor.black
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.numberOfLines = 0
        return contentLabel
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(KDReplyCell.classForCoder(), forCellReuseIdentifier: "kd_reply_cell")
        return tableView
    }()
}

// MARK: UITableViewDelegate
extension KDTopicDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < viewModel.topicReplies.count {
            let model = viewModel.topicReplies[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "kd_reply_cell") as! KDReplyCell
            model.floor = indexPath.row + 1
            cell.loadData(model)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < viewModel.topicReplies.count {
        }
    }
}

// MARK: UITableViewDataSource
extension KDTopicDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.topicReplies.count;
    }
}
