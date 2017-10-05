//
//  KDTopicDetailViewController.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit
import WebKit

class KDTopicDetailViewController : KDBaseViewController {
    
    var viewModel = KDTopicDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "主题详情"
        setupView()
        loadData()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            let oldSize = change![.oldKey] as! NSValue
            let newSize = change![.newKey] as! NSValue
            if oldSize != newSize {
                let height =  newSize.cgSizeValue.height
                contentView.snp.updateConstraints({ (make) in
                    make.height.equalTo(height)
                })
            }
            tableView.tableHeaderView = tableHeaderView
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    // MARK: Private Method
    private func setupView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        setupTableHeader()
    }
    
    private func loadData() {
        let topic = viewModel.topic
        titleLabel.text = topic.title
        descriptionLabel.text = "By \(topic.member?.username ?? "") at \(topic.created?.formatDate() ?? "")"
        let html = KDResources.topicHTML(topic.contentRendered ?? "")
        contentView.loadHTMLString(html, baseURL: nil)
        tableView.layoutIfNeeded()
        let params = ["topic_id": topic.id]
        viewModel.fetchTopicReplies(params: params as [String : AnyObject], success: { (data) in
            self.tableView.reloadData()
        }) { (error) in
        }
    }
    
    private func setupTableHeader() {
        tableView.tableHeaderView = tableHeaderView
        tableHeaderView.addSubview(titleLabel)
        tableHeaderView.addSubview(descriptionLabel)
        tableHeaderView.addSubview(contentView)
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
        contentView.snp.makeConstraints { (make) in
            make.height.equalTo(0)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.bottom.equalTo(tableHeaderView).offset(-10)
            make.left.equalTo(tableHeaderView).offset(15)
            make.right.equalTo(tableHeaderView).offset(-15)
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
    
    private lazy var contentView: WKWebView = {
        var contentView = WKWebView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.allowsLinkPreview = true
        contentView.scrollView.isScrollEnabled = false
        contentView.scrollView.addObserver(self, forKeyPath: "contentSize", options: [.old, .new], context: nil)
        return contentView
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
extension KDTopicDetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < viewModel.topicReplies.count {
            let model: KDReplyModel = viewModel.topicReplies[indexPath.row]
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
extension KDTopicDetailViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.topicReplies.count;
    }
}
