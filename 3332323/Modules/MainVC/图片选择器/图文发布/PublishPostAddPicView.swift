//
//  PublishPostAddPicView.swift
//  3332323
//
//  Created by dd on 31/7/2021.
//

import Foundation

import UIKit

class PublishPostAddPicView: UIView {
    
    var maxImageCount: Int = 9
    var maxVideoCount: Int = 1
    var addPicBlock: (() -> Void)?
//    var deletePicBlock: ((LivePhotoAssetProtocol, Int) -> Void)?
//    var selectPicBlock: ((LivePhotoAssetProtocol, Int) -> Void)?
//
//    private var selectedAssets: [LivePhotoAssetProtocol] = []
//
//    private lazy var collectionView: UICollectionView = {
//        let flowLayout = UICollectionViewFlowLayout()
//        let width = 80 * UIScreen.scaleRadio
//        flowLayout.itemSize = CGSize(width: width, height: width)
//        let spacing = (UIScreen.width - width * 3 - 3) * 0.25
//        flowLayout.minimumLineSpacing = 10 * UIScreen.scaleRadio
//        flowLayout.minimumInteritemSpacing = spacing // 10 * UIScreen.scaleRadio
//        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        view.backgroundColor = .clear
//
//
//        view.contentInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
//        view.register(PublishPostAddPicCell.self, forCellWithReuseIdentifier: NSStringFromClass(PublishPostAddPicCell.self))
//        view.delegate = self
//        view.dataSource = self
//        return view
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        subviewsInitAndSnp()
//
//    }
//
//    private var adjustHeight: CGFloat {
//        let count = (selectedAssets.count >= maxImageCount ? maxImageCount : (selectedAssets.count + 1))
//        let line = count / 3 + (count % 3 > 0 ? 1 : 0)
//        return CGFloat(90 * line - 10) * UIScreen.scaleRadio + 20
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
//
//extension PublishPostAddPicView {
//
//    func updateData(_ assets: [LivePhotoAssetProtocol]) {
//        selectedAssets = assets
//        collectionView.reloadData()
//        collectionView.snp.updateConstraints { make in
//            make.height.equalTo(adjustHeight)
//        }
//        layoutIfNeeded()
//    }
//
//}
//
//private extension PublishPostAddPicView {
//
//    func subviewsInitAndSnp() {
//        addSubview(collectionView)
//
//        collectionView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//            make.height.equalTo(adjustHeight)
//        }
//    }
//
//}
//
//extension PublishPostAddPicView: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if selectedAssets.first?.type == .video {
//            return selectedAssets.count >= maxVideoCount ? maxVideoCount : (selectedAssets.count + 1)
//        }
//        return selectedAssets.count >= maxImageCount ? maxImageCount : (selectedAssets.count + 1)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PublishPostAddPicCell.self), for: indexPath) as! PublishPostAddPicCell
//        if (indexPath.row + 1) > selectedAssets.count {
//            cell.picImgView.contentMode = .center
//            cell.picImgView.image = "community_icon_addition".image
//            cell.deleteBtn.isHidden = true
//        } else {
//            cell.deleteBtn.isHidden = false
//            cell.picImgView.contentMode = .scaleAspectFill
//            cell.deleteBlock = { [weak self] in
//                guard let asset = self?.selectedAssets[indexPath.row] else { return }
//                self?.deletePicBlock?(asset, indexPath.row)
//            }
//            let asset = selectedAssets[indexPath.row]
//            asset.getShowImage { [weak cell] img in
//                cell?.picImgView.image = img
//            }
//        }
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if (indexPath.row + 1) > selectedAssets.count {
//            addPicBlock?()
//            return
//        }
//        selectPicBlock?(selectedAssets[indexPath.row], indexPath.row)
//    }
    
}
