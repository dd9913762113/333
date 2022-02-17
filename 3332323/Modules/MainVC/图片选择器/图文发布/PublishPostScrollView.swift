//
//  PublishPostScrollView.swift
//  3332323
//
//  Created by dd on 31/7/2021.
//

import Foundation
import UIKit

struct LivePostTag: Codable {
    
    /// 标签自增id
    let id: Int
    
    /// 标签所属版块： 1视频 2图片 3短文 4社区
    let plate: Int
    
    /// 标签名称
    let tag_name: String
    
    /// 标签显示的颜色
    let tag_color: String
    
    /// 标签状态：1：启用 2：停用
    let status: Int
    
    /// 标签备注
    let remark: String
    
    /// 操作人
    let oper: String
    
    /// 创建时间
    let created_at: String
    
    /// 修改时间
    let updated_at: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case plate
        case tag_name
        case tag_color
        case status
        case remark
        case oper = "operator"
        case created_at
        case updated_at
    }
    
}


class PublishPostScrollView: UIScrollView {
    
    private let containView = UIView()
    
    let inputPostView = PublishPostInputView()
    
    let addTopicBtn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 110, height: 30)))
    
    let topicView = PublishPostTopicView()
    
    let addPicView = PublishPostAddPicView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        subviewsInitAndSnp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PublishPostScrollView {
    
    func reset() {
        inputPostView.reset()
        topicView.updateData([])
//        addPicView.updateData([])
    }
    
}

private extension PublishPostScrollView {
    
    func subviewsInitAndSnp() {
        addTopicBtn.titleLabel?.font = UIFont.PingFang.regularFont(ofSize: 14)
        addTopicBtn.setTitleColor(UIColor.white, for: .normal)
        addTopicBtn.setTitleColor(UIColor.white, for: .highlighted)
        addTopicBtn.setImage(UIImage(named: "community_icon_topic"), for: .normal)
        addTopicBtn.setImage(UIImage(named: "community_icon_topic"), for: .highlighted)
        addTopicBtn.setTitle("添加话题", for: .normal)
        addTopicBtn.imageEdgeInsets = UIEdgeInsets(top: 3, left: -5, bottom: 0, right: 0)
        addTopicBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
//        addTopicBtn.set(enableColor: (UIColor(HEXRGBStr: "0xFF7DCA"), UIColor(HEXRGBStr: "0xFC4E89")))
//        addTopicBtn.setCornerRadius(cornerRadius: 15)
        
        containView.addSubview(inputPostView)
        containView.addSubview(addPicView)
        containView.addSubview(addTopicBtn)
        containView.addSubview(topicView)
        addSubview(containView)

        containView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width)
            make.bottom.equalTo(topicView.snp.bottom).offset(10)
        }
        inputPostView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(4)
            make.top.equalToSuperview().offset(9)
            make.height.equalTo(326)
        }
        addPicView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(inputPostView.snp.bottom).offset(6)
        }
        addTopicBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(addPicView.snp.bottom)
            make.size.equalTo(CGSize(width: 110, height: 30))
        }
        topicView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(addTopicBtn.snp.bottom).offset(15)
        }
    }

}

class PublishPostTopicView: UIView {
    
    var cancelBlock: ((LivePostTag) -> Void)?
    private var selectedTags: [LivePostTag] = []

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 16) / 3, height: 45)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 1
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
        view.register(PublishPostTopicCell.self, forCellWithReuseIdentifier: NSStringFromClass(PublishPostTopicCell.self))
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    
    private var currentHeight: CGFloat {
        return CGFloat(selectedTags.count * 45)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        subviewsInitAndSnp()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.collectionView.snp.updateConstraints { make in
                make.height.equalTo(135)
            }
            self.layoutIfNeeded()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PublishPostTopicView {
    
    func updateData(_ tags: [LivePostTag]) {
        selectedTags = tags
        collectionView.snp.updateConstraints { make in
            make.height.equalTo(currentHeight)
        }
        layoutIfNeeded()
        collectionView.reloadData()
    }
    
}

private extension PublishPostTopicView {
    
    func subviewsInitAndSnp() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(currentHeight)
        }
    }
    
}

extension PublishPostTopicView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PublishPostTopicCell.self), for: indexPath) as! PublishPostTopicCell
        cell.updateData(selectedTags[indexPath.row])
        cell.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.selectedTags.remove(at: indexPath.row)
//            self.cancelBlock?(self.selectedTags)
        }
        return cell
    }
    
}





