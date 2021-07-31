//
//  PublishPostTopicCell.swift
//  3332323
//
//  Created by dd on 31/7/2021.
//

import Foundation

import UIKit

class PublishPostTopicCell: UICollectionViewCell {
    
    var cancelBlock: (() -> Void)?
    
    private let bgImgView = UIImageView()
    private let cancelBtn = UIButton()
    private let tagLb = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subviewsInitAndSnp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PublishPostTopicCell {
    
    func updateData(_ topic: LivePostTag) {
        tagLb.text = topic.tag_name
        tagLb.textColor = UIColor(HEXRGBStr: topic.tag_color.replacingOccurrences(of: "#", with: "0x"))
    }
    
}

private extension PublishPostTopicCell {
    
    func subviewsInitAndSnp() {
//        bgImgView.image = UIImage(named:"community_table_big").resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 55), resizingMode: .stretch)
        bgImgView.image = UIImage(named:"community_table_big")
        cancelBtn.setBackgroundImage(UIImage(named:"community_icon_close"), for: .normal)
        cancelBtn.setBackgroundImage(UIImage(named:"community_icon_close"), for: .highlighted)
        cancelBtn.minClickArea = CGSize(width: 44, height: 44)
        cancelBtn.addTarget(self, action: #selector(handleCancelAction), for: .touchUpInside)
        
        tagLb.font = UIFont.PingFang.regularFont(ofSize: 14)
        tagLb.textColor = .red
        tagLb.textAlignment = .center
        
        contentView.addSubview(bgImgView)
        contentView.addSubview(tagLb)
        contentView.addSubview(cancelBtn)
        
        bgImgView.snp.makeConstraints { make in
            make.centerY.left.right.equalToSuperview()
            make.height.equalTo(45)
        }
        tagLb.snp.makeConstraints { make in
            make.centerY.equalTo(cancelBtn)
            make.left.right.equalToSuperview().inset(30)
        }
        cancelBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.right.equalToSuperview().offset(-11)
            make.size.equalTo(CGSize(width: 18, height: 18))
        }
    }
    
}

//MARK: - action
private extension PublishPostTopicCell {
    
    @objc func handleCancelAction() {
        cancelBlock?()
    }
    
}
