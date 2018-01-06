//
//  KDTopicDetailViewController.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit
import WebKit
import SafariServices
import MBProgressHUD

fileprivate extension Selector {
    static let forwardWeb = #selector(KDTopicDetailViewController.forwardWeb)
}

class KDTopicDetailViewController : KDBaseViewController {
    
    var viewModel = KDTopicDetailViewModel()
    var topic = KDTopicModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "主题详情"
        setupView()
        loadData()
    }
    
    deinit {
        contentView.scrollView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            guard let oldSize = change?[.oldKey] as? NSValue else { return }
            guard let newSize = change?[.newKey] as? NSValue else { return }
            if oldSize != newSize {
                contentView.snp.updateConstraints({ (make) in
                    make.height.equalTo(newSize.cgSizeValue.height)
                })
            }
            tableView.tableHeaderView = tableHeaderView
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        let cancel = UIPreviewAction(title: "取消",
                                     style: .destructive,
                                     handler: {(cacel: UIPreviewAction, self: UIViewController) in print("cancel")})
        return [cancel]
    }
    
    private func setupView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        setupTableHeader()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "kd_forward"), style: .plain, target: self, action: .forwardWeb)
    }
    
    @objc fileprivate func forwardWeb() {
        guard let topicUrl = topic.url else { return }
        guard let url = URL(string: KDConfig.APIHost() + topicUrl) else { return }
        openURL(url)
    }
    
    private func openURL(_ url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    
    private func loadData() {
        MBProgressHUD.showAdded(to: view, animated: true)
        viewModel.topic = topic
        titleLabel.text = topic.title
        descriptionLabel.text = "By \(topic.createdName ?? "")";//" at \(topic.created?.formatDate() ?? "")"
        viewModel.fetchTopicDetail(topicUrl: topic.url!, success: { [weak self] data in
            guard let strongSelf = self else { return }
            strongSelf.topic = data
            strongSelf.refreshView()
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
        }) { [weak self] (error) in
            guard let strongSelf = self else { return }
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
        }
    }
    
    private func refreshView() {
        let html = KDResources.topicHTML(topic.content ?? "")
        contentView.loadHTMLString(html, baseURL: nil)
        tableView.reloadData()
        tableView.layoutIfNeeded()
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
        descriptionLabel.textColor = UIColor.hex("999999")
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.bottomLine()
        return descriptionLabel
    }()
    
    private lazy var contentView: WKWebView = {
        var contentView = WKWebView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.allowsLinkPreview = true
        contentView.scrollView.isScrollEnabled = false
        contentView.navigationDelegate = self
        contentView.scrollView.addObserver(self, forKeyPath: "contentSize", options: [.old, .new], context: nil)
        return contentView
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = .none
        tableView.register(KDReplyCell.classForCoder(), forCellReuseIdentifier: "kd_reply_cell")
        return tableView
    }()
}

extension KDTopicDetailViewController : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if url?.scheme == "http" || url?.scheme == "https" {
            openURL(url!)
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
}

// MARK: UITableViewDelegate
extension KDTopicDetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "kd_reply_cell") as? KDReplyCell else {
            return UITableViewCell()
        }
        let model: KDReplyModel = viewModel.topicReplies[indexPath.row]
        cell.loadData(model)
        cell.clickAvatar = { [weak self] username in
            guard let strongSelf = self else { return }
            let userViewController = KDUserViewController().then {
                $0.username = username
                $0.hidesBottomBarWhenPushed = true
            }
            strongSelf.navigationController?.pushViewController(userViewController, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UITableViewDataSource
extension KDTopicDetailViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.topicReplies.count;
    }
}
