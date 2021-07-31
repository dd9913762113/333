//
//  PublishPostInputView.swift
//  3332323
//
//  Created by dd on 31/7/2021.
//

import Foundation
import UIKit

class PublishPostInputView: UIView {
    
    var textChangeBlock: ((String) -> Void)?
    
    var watchRuleBlock: (() -> Void)?
    
    let detailText = CommonTextView()
    
    var limitCount: Int = 50 {
        didSet {
            countLb.text = "\(detailText.text.count)/\(limitCount <= 0 ? 50 : limitCount)"
        }
    }
    
    private let bgImgView = UIImageView()
    
    private let countLb = UILabel()
    
    private let ruleBtn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 90, height: 28)))
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        subviewInitAndSnp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PublishPostInputView {
    
    func reset() {
        detailText.text = nil
        countLb.text = "0/\(limitCount)"
    }
    
}

private extension PublishPostInputView {
    
    func subviewInitAndSnp() {
        bgImgView.image = UIImage(named:"community_mod_bg_04")?.resizableImage(withCapInsets: UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40), resizingMode: .stretch)
        
        detailText.backgroundColor = .clear
        detailText.placeholder = "请输入介绍信息……"
        detailText.placeholderColor = UIColor.Color_A89797
        detailText.font = UIFont.PingFang.regularFont(ofSize: 11)
        detailText.textColor = UIColor.Color_6B6060
        detailText.tintColor = UIColor.Color_6B6060
        detailText.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        detailText.layer.cornerRadius = 8
        detailText.layer.borderWidth = 1
        detailText.layer.borderColor = UIColor(HEXRGBStr: "0xE7AC85").cgColor
        detailText.layer.masksToBounds = true
        detailText.delegate = self
        
        countLb.font = UIFont.PingFang.regularFont(ofSize: 11)
        countLb.textColor = UIColor.Color_6B6060
        countLb.text = "0/\(limitCount)"
        
        ruleBtn.titleLabel?.font = UIFont.PingFang.regularFont(ofSize: 14)
        ruleBtn.setTitleColor(UIColor.Color_6B6060, for: .normal)
        ruleBtn.setTitleColor(UIColor.Color_6B6060, for: .highlighted)
        ruleBtn.setTitle("规则说明", for: .normal)
        ruleBtn.layoutButtonImageEdgeInsetsStyle(style: .right, space: 20)
        if let img = UIImage(named: "community_icon_return") , let cgImg = img.cgImage {
            ruleBtn.setImage(UIImage(cgImage: cgImg, scale: img.scale, orientation: .upMirrored), for: .normal)
        }
        ruleBtn.addTarget(self, action: #selector(handleWatchRuleAction), for: .touchUpInside)

        addSubview(bgImgView)
        addSubview(detailText)
        addSubview(countLb)
        addSubview(ruleBtn)

        bgImgView.snp.makeConstraints { make in
            if UIDevice.current.hasSafeArea{
                make.top.equalTo(98)
            }else{
                make.top.equalTo(54)
            }
            make.left.right.equalToSuperview()
            make.height.equalTo(298)
        }
        detailText.snp.makeConstraints { make in
            make.left.right.equalTo(bgImgView).inset(24)
            make.top.equalTo(bgImgView).offset(16)
            make.bottom.equalTo(bgImgView).offset(-21)
        }
        ruleBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(bgImgView.snp.bottom)
            make.size.equalTo(CGSize(width: 90, height: 28))
        }
        countLb.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalTo(ruleBtn)
        }
    }
    
    @objc func handleWatchRuleAction() {
        watchRuleBlock?()
    }
    
}

extension PublishPostInputView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard limitCount > 0 else {
            return true
        }
        if textView.markedTextRange != nil {
            return true
        }
        if text.count == 0 && range.length > 0 {
            return true
        }
        if (textView.text.count + text.count - range.length) > limitCount {
            return false
        }
        return text.textInputIsVaild
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if (nil == textView.markedTextRange && limitCount > 0 && textView.text.count > limitCount) {
            textView.text = textView.text.mySubString(to: limitCount)
        }
        countLb.text = "\(textView.text.count)/\(limitCount)"
        textChangeBlock?(textView.text)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = textView.text.replacingOccurrences(of: "#", with: "").replacingOccurrences(of: "@", with: "")
        textChangeBlock?(textView.text)
    }
    
}






