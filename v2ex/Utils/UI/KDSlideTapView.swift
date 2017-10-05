//
//  KDSlideTapView.swift
//  v2ex
//
//  Created by donghao on 2017/10/4.
//  Copyright © 2017年 kyle. All rights reserved.
//
//  FIXME: 高度约束有问题，滑动有问题，底部分割线

import UIKit

import SnapKit

protocol KDSlideTapDelegate : NSObjectProtocol {
    
    func slideTapView(_ slideTapView: KDSlideTapView, titleAtIndex index: Int) -> String
    func slideTapViewNumberOfRows(_ slideTapView: KDSlideTapView) -> Int
    
    // optional
    func slideTapView(in slideTapView: KDSlideTapView, didSelectAtIndex index: Int)
    func slideTapView(in slideTapView: KDSlideTapView, itemWidthAtIndex index: Int) -> Int
}

extension KDSlideTapDelegate {
    
    func slideTapView(in slideTapView: KDSlideTapView, didSelectAtIndex index: Int) {
    }
    
    func slideTapView(in slideTapView: KDSlideTapView, itemWidthAtIndex index: Int) -> Int {
        return 45
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
        slideTapDelegate?.slideTapView(in: self, didSelectAtIndex: button.tag - 1)
        currentIndex = button.tag - 1
    }
    
    // MARK: Private Method
    private func setupView() {
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(5)
            make.left.equalTo(self).offset(5)
            make.right.greaterThanOrEqualTo(self).offset(-5)
            make.bottom.equalTo(self).offset(-5)
        }
    }
    
    private func setItems() {
        numberOfRows = slideTapDelegate?.slideTapViewNumberOfRows(self) ?? 0
        for index in 0 ..< numberOfRows {
            let button = tagButton()
            let title = slideTapDelegate?.slideTapView(self, titleAtIndex: index) ?? ""
            button.setTitle("  \(title)  ", for: UIControlState.normal)
            button.tag = index + 1
            stackView.addArrangedSubview(button)
        }
        let buttons = stackView.arrangedSubviews
        if buttons.count > 0 {
            let button = buttons[currentIndex] as! UIButton
            setSelectedItem(button)
        }
    }
    
    private func tagButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(KDUIKitUtil.HEXCOLOR("555555"), for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(tapAction(_:)), for: UIControlEvents.touchUpInside)
        button.snp.makeConstraints { (make) in
            make.height.equalTo(25)
        }
        return button
    }
    
    private func setSelectedItem(_ button: UIButton) {
        let oldButton = selectedItem
        oldButton?.isSelected = false
        oldButton?.backgroundColor = .clear
        oldButton?.setTitleColor(KDUIKitUtil.HEXCOLOR("555555"), for: UIControlState.normal)
        
        button.isSelected = true
        button.backgroundColor = KDUIKitUtil.HEXCOLOR("333344")
        button.setTitleColor(KDUIKitUtil.HEXCOLOR("ffffff"), for: UIControlState.normal)
        selectedItem = button
    }
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
}
