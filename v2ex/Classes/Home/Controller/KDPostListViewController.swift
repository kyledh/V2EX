//
//  KDPostListViewController.swift
//  v2ex
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

import PKHUD

class KDPostListViewController: KDBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_setupView()
    }
    
    // MARK: Private Method
    private func p_setupView() {
        view.addSubview(tableView)
        tableView .snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    // MARK: Lazy Loading
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        return tableView
    }()
}

// MARK: UITableViewDelegate
extension KDPostListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HUD.flash(.label("点击Cell"))
    }
}

// MARK: UITableViewDataSource
extension KDPostListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
}
