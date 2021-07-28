//
//  HomeVidelItem.swift
//  demo-iOS
//
//  Created by dd on 18/7/2021.
//  Copyright © 2021 kintan. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class HomeVidelItem: UICollectionViewCell {
    
    var tagBtn = UIButton()
    var thumbnailImg = UIImageView()
    var MiddelBGImg = UIImageView()
    var TimeIcon = UIImageView()
    var TimeLab = UILabel()
    var favoriteIcon = UIImageView()
    var favoriteCountLab = UILabel()

    var bottomBgImg = UIImageView()
    var VidelTielLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        setUpSubView()
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpSubView() {
//        thumbnailImg.image = BOBImagePng.LVHItemTopBGImg.currentImage
//        thumbnailImg.yi_add(.top, value: 10)
        thumbnailImg.contentMode = .scaleAspectFill
        contentView.addSubview(thumbnailImg)
        
//        bottomBgImg.image = BOBImagePng.LVHItemBottomBGImg.currentImage
        contentView.addSubview(bottomBgImg)
        
        VidelTielLabel.text = "标题"
        VidelTielLabel.font = UIFont.systemFont(ofSize: 12)
        VidelTielLabel.textColor = UIColor.systemRed
        VidelTielLabel.numberOfLines = 2
        contentView.addSubview(VidelTielLabel)
        
        MiddelBGImg.isUserInteractionEnabled = true
//        MiddelBGImg.image = BOBImagePng.LVHItemMiddleBGImg.image
        contentView.addSubview(MiddelBGImg)
        
//        TimeIcon.image = BOBImagePng.LVHItemTimeIcon.image
        MiddelBGImg.addSubview(TimeIcon)
        
        TimeLab.text = "00:00:00"
        TimeLab.font = UIFont.systemFont(ofSize: 11)
        TimeLab.textAlignment = .right
        TimeLab.textColor = UIColor.white
        MiddelBGImg.addSubview(TimeLab)
        
//        favoriteIcon.image = BOBImagePng.LVHItemFavoriteIcon.image
        MiddelBGImg.addSubview(favoriteIcon)
        
        favoriteCountLab.text = "1000"
        favoriteCountLab.font = UIFont.systemFont(ofSize: 11)
        favoriteCountLab.textColor = UIColor.white
        MiddelBGImg.addSubview(favoriteCountLab)
        
        contentView.addSubview(tagBtn)
    }
    
    func setupConstraints() {
        thumbnailImg.snp.makeConstraints {
            $0.left.equalTo(6)
            $0.top.equalTo(5)
            $0.right.equalTo(-6)
            $0.bottom.equalToSuperview().offset(-40)
        }
        tagBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(6)
            $0.top.equalToSuperview().offset(5)
            $0.height.equalTo(18)
            $0.width.equalTo(70)
        }
        MiddelBGImg.snp.makeConstraints {
            $0.left.equalToSuperview().offset(7)
            $0.right.equalToSuperview().offset(-7)
            $0.bottom.equalTo(thumbnailImg)
            $0.height.equalTo(52)
        }

        favoriteIcon.snp.makeConstraints {
            $0.left.equalToSuperview().offset(9)
            $0.height.width.equalTo(12)
            $0.bottom.equalTo(-6)
        }
        favoriteCountLab.snp.makeConstraints {
            $0.left.equalTo(favoriteIcon.snp.right).offset(3)
            $0.height.equalTo(20)
            $0.width.equalTo(70)
            $0.centerY.equalTo(favoriteIcon)
        }
        
        TimeLab.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-8)
            $0.height.equalTo(20)
            $0.width.equalTo(50)
            $0.centerY.equalTo(favoriteIcon)
        }
        TimeIcon.snp.makeConstraints {
            $0.right.equalTo(TimeLab.snp.left).offset(-5)
            $0.height.width.equalTo(12)
            $0.centerY.equalTo(TimeLab)
        }
        bottomBgImg.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        VidelTielLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-8)
            $0.top.equalTo(thumbnailImg.snp.bottom)
        }
    }
    
}


//        tagBtn.setBackgroundImage(BOBImagePng.LVHItemTypeHotIcon.image, for: .normal)
//  视频界面的 tag 新人 UP 最新 推荐 热门
extension HomeVidelItem {
    func setModelData(model: mediaResModel?) {
        thumbnailImg.kf.setImage(with: URL.init(string: (model?.images.first ?? "") ))
//        favoriteCountLab.text = model?.collectcount.numHeader()
        VidelTielLabel.text = model?.title
        
    }
}
