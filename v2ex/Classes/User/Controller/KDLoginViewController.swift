//
//  KDLoginViewController.swift
//  v2ex
//
//  Created by donghao on 2017/10/14.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit
import Kingfisher

class KDLoginViewController: KDBaseViewController {
    
    var viewModel = KDLoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登录"
        setupViews()
        fetchData()
    }
    
    private func fetchData() {
        viewModel.fetchVerificationCode(success: { [weak self] code in
            guard let strongSelf = self else { return }
            KDAPIClient.shared.getRequest(path: code, params: nil, success: { data in
                strongSelf.codeImage.image = UIImage(data: data!)
            }, failure: { error in
            })
        }, failure: { error in
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupViews() {
        view.addSubview(usernameTitle)
        view.addSubview(usernameField)
        view.addSubview(passwordTitle)
        view.addSubview(passwordField)
        view.addSubview(codeImage)
        view.addSubview(codeTitle)
        view.addSubview(codeField)
        view.addSubview(submitButton)
        usernameTitle.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(30)
            make.left.equalTo(view).offset(30)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        usernameField.snp.makeConstraints { (make) in
            make.centerY.equalTo(usernameTitle)
            make.left.equalTo(usernameTitle.snp.right).offset(15)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(30)
        }
        passwordTitle.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTitle.snp.bottom).offset(20)
            make.left.equalTo(view).offset(30)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        passwordField.snp.makeConstraints { (make) in
            make.centerY.equalTo(passwordTitle)
            make.left.equalTo(passwordTitle.snp.right).offset(15)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(30)
        }
        codeImage.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTitle.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.height.equalTo(40)
            make.width.equalTo(160)
        }
        codeTitle.snp.makeConstraints { (make) in
            make.top.equalTo(codeImage.snp.bottom).offset(20)
            make.left.equalTo(view).offset(30)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        codeField.snp.makeConstraints { (make) in
            make.centerY.equalTo(codeTitle)
            make.left.equalTo(codeTitle.snp.right).offset(15)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(30)
        }
        submitButton.snp.makeConstraints { (make) in
            make.top.equalTo(codeTitle.snp.bottom).offset(40)
            make.centerX.equalTo(view)
            make.height.equalTo(40)
            make.width.equalTo(160)
        }
    }
    
    private lazy var usernameTitle: UILabel = {
        var label = UILabel()
        label.text = "用户名"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var usernameField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "请输入用户名"
        textField.textColor = UIColor.black
        textField.font = UIFont.systemFont(ofSize: 16)
        if #available(iOS 11.0, *) {
            textField.textContentType = .username
        }
        textField.delegate = self
        textField.returnKeyType = .done
        textField.bottomLine()
        return textField
    }()
    
    private lazy var passwordTitle: UILabel = {
        var label = UILabel()
        label.text = "密码"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var passwordField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "请输入密码"
        textField.textColor = UIColor.black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.isSecureTextEntry = true
        if #available(iOS 11.0, *) {
            textField.textContentType = .password
        }
        textField.delegate = self
        textField.returnKeyType = .done
        textField.bottomLine()
        return textField
    }()
    
    private lazy var codeImage: UIImageView = {
        var imageView = UIImageView()
        if #available(iOS 11, *) {
            imageView.accessibilityIgnoresInvertColors = true
        }
        return imageView
    }()
    
    private lazy var codeTitle: UILabel = {
        var label = UILabel()
        label.text = "验证码"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var codeField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "请输入验证码"
        textField.textColor = UIColor.black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.delegate = self
        textField.returnKeyType = .done
        textField.bottomLine()
        return textField
    }()
    
    private lazy var submitButton: UIButton = {
        var button = UIButton()
        button.setTitle("登录", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.hex("999999")?.cgColor
        button.layer.cornerRadius = 2
        return button
    }()
}

extension KDLoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
