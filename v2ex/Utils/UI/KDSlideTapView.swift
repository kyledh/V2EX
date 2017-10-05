//
//  KDSlideTapView.swift
//  v2ex
//
//  Created by donghao on 2017/10/4.
//  Copyright © 2017年 kyle. All rights reserved.
//
//  FIXME: 高度约束有问题，底部分割线

import UIKit

import SnapKit

protocol KDSlideTapDelegate : NSObjectProtocol {
    
    func slideTapView(_ slideTapView: KDSlideTapView, titleAtIndex index: Int) -> String
    func slideTapViewNumberOfRows(_ slideTapView: KDSlideTapView) -> Int
    
    // optional
    func slideTapView(in slideTapView: KDSlideTapView, didSelectAtIndex index: Int)
}

extension KDSlideTapDelegate {
    
    func slideTapView(in slideTapView: KDSlideTapView, didSelectAtIndex index: Int) {
    }
}

class KDSlideTapView: UIScrollView {

    var numberOfRows = 0
    var currentIndex: Int! {
        didSet {
            let index = currentIndex + 1
            if index > 0 && index <= numberOfRows {
                let button = viewWithTag(index) as! UIButton
                setSelectedItem(button)
            }
        }
    }
    var selectedItem: UIButton?
    var slideTapDelegate: KDSlideTapDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        currentIndex = 0
        showsHorizontalScrollIndicator = false
        bounces = false
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        setItems()
    }
    
    @objc func tapAction(_ button: UIButton) {
        if button == selectedItem {
            return
        }
        if slideTapDelegate != nil {
            slideTapDelegate!.slideTapView(in: self, didSelectAtIndex: button.tag - 1)
        }
        currentIndex = button.tag - 1
    }
    
    // MARK: Private Method
    private func setupView() {
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(2.5)
            make.left.equalTo(self).offset(5)
            make.bottom.equalTo(self).offset(-2.5)
        }
    }
    
    private func setItems() {
        removeArrangedSubviews()
        if slideTapDelegate == nil {
            return
        }
        numberOfRows = slideTapDelegate!.slideTapViewNumberOfRows(self)
        for index in 0 ..< numberOfRows {
            let button = tagButton()
            let title = slideTapDelegate!.slideTapView(self, titleAtIndex: index)
            button.setTitle("  \(title)  ", for: UIControlState.normal)
            button.tag = index + 1
            stackView.addArrangedSubview(button)
        }
        let buttons = stackView.arrangedSubviews
        if buttons.count > 0 {
            let button = buttons[currentIndex] as! UIButton
            setSelectedItem(button)
        }
        layoutIfNeeded()
        contentSize = CGSize.init(width: stackView.frame.width + 10, height: 0)
    }
    
    private func tagButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(KDUIKitUtil.HEXCOLOR("555555"), for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.backgroundColor = KDUIKitUtil.HEXCOLOR("f5f5f5")
        button.addTarget(self, action: #selector(tapAction(_:)), for: UIControlEvents.touchUpInside)
        button.snp.makeConstraints { (make) in
            make.height.equalTo(25)
        }
        return button
    }
    
    private func setSelectedItem(_ button: UIButton) {
        let oldButton = selectedItem
        oldButton?.isSelected = false
        oldButton?.backgroundColor = KDUIKitUtil.HEXCOLOR("f5f5f5")
        oldButton?.setTitleColor(KDUIKitUtil.HEXCOLOR("555555"), for: UIControlState.normal)
        
        button.isSelected = true
        button.backgroundColor = KDUIKitUtil.HEXCOLOR("333344")
        button.setTitleColor(KDUIKitUtil.HEXCOLOR("ffffff"), for: UIControlState.normal)
        selectedItem = button
    }
    
    private func removeArrangedSubviews() {
        let views = stackView.arrangedSubviews
        for button in views {
            stackView.removeArrangedSubview(button)
            button.removeFromSuperview()
        }
    }
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
}
