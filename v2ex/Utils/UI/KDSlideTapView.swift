//
//  KDSlideTapView.swift
//  v2ex
//
//  Created by donghao on 2017/10/4.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit
import SnapKit

fileprivate extension Selector {
    static let tapAction = #selector(KDSlideTapView.tapAction(_:))
}

protocol KDSlideTapDelegate : NSObjectProtocol {
    
    func slideTapView(_ slideTapView: KDSlideTapView, titleAtIndex index: Int) -> String
    func slideTapViewNumberOfRows(_ slideTapView: KDSlideTapView) -> Int
    
    // optional
    func slideTapView(in slideTapView: KDSlideTapView, didSelectAtIndex index: Int)
}

extension KDSlideTapDelegate {
    
    func slideTapView(in slideTapView: KDSlideTapView, didSelectAtIndex index: Int) {}
}

class KDSlideTapView: UIView {

    var numberOfRows = 0
    var currentIndex: Int = 0 {
        didSet {
            guard let button = viewWithTag(currentIndex + 1) as? UIButton else { return }
            setSelectedItem(button)
            scrollToRowAtIndex(index: currentIndex)
        }
    }
    var selectedItem: UIButton?
    var slideTapDelegate: KDSlideTapDelegate?

    public func reloadData() {
        setItems()
    }
    
    @objc fileprivate func tapAction(_ button: UIButton) {
        guard button != selectedItem else { return }
        slideTapDelegate?.slideTapView(in: self, didSelectAtIndex: button.tag - 1)
        currentIndex = button.tag - 1
    }
    
    public func scrollToRowAtIndex(index: Int) {
        guard selectedItem != nil else { return }
        let offset = selectedItem!.center.x - (contentView.width - 10) / 2
        let x = min(contentView.contentSize.width - contentView.width, offset)
        contentView.setContentOffset(CGPoint(x: max(x, 0), y: 0), animated: true)
    }

    private func setItems() {
        removeArrangedSubviews()
        guard let _ = slideTapDelegate else { return }
        numberOfRows = slideTapDelegate!.slideTapViewNumberOfRows(self)
        for index in 0 ..< numberOfRows {
            let button = tagButton()
            let title = slideTapDelegate!.slideTapView(self, titleAtIndex: index)
            button.setTitle("  \(title)  ", for: UIControlState.normal)
            button.tag = index + 1
        }
        guard let button = stackView.arrangedSubviews.first as? UIButton else { return }
        setSelectedItem(button)
        layoutIfNeeded()
    }
    
    private func tagButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.hex("555555"), for: .normal)
        button.setTitleColor(UIColor.hex("ffffff"), for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.backgroundColor = UIColor.hex("f5f5f5")
        button.addTarget(self, action: .tapAction, for: UIControlEvents.touchUpInside)
        stackView.addArrangedSubview(button)
        return button
    }
    
    private func setSelectedItem(_ button: UIButton) {
        let oldButton = selectedItem
        oldButton?.isSelected = false
        oldButton?.backgroundColor = UIColor.hex("f5f5f5")

        button.isSelected = true
        button.backgroundColor = UIColor.hex("333344")
        selectedItem = button
    }
    
    private func removeArrangedSubviews() {
        for button in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(button)
            button.removeFromSuperview()
        }
    }
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView).inset(UIEdgeInsetsMake(0, 5, 0, 5))
            make.height.equalTo(contentView)
        }
        return stackView
    }()
    
    private lazy var contentView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        addSubview(scrollView)
        scrollView.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        return scrollView
    }()
}
