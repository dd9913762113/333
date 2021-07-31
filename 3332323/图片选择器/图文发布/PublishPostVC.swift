//
//  PublishPostVC.swift
//  3332323
//
//  Created by dd on 31/7/2021.
//

import Foundation
import UIKit


class PublishPostVC: UIViewController {
    public let _commonBgImageView = UIImageView(frame: .zero)
    private let publishBtn = UIButton(type: .custom)
    private let scrollView = PublishPostScrollView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subviewsInitAndSnp()
        
    }
    
}


//MARK: - UI
private extension PublishPostVC {
    
    func subviewsInitAndSnp() {
  
        title = "发帖"
        
        publishBtn.titleLabel?.font = UIFont.PingFang.semiboldFont(ofSize: 18)
        publishBtn.setTitleColor(UIColor.Color_6B6060, for: .normal)
        publishBtn.setTitleColor(UIColor.Color_6B6060, for: .highlighted)
        publishBtn.setTitle("发布", for: .normal)
        publishBtn.addTarget(self, action: #selector(handlePublishAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: publishBtn)
        
        _commonBgImageView.image = UIDevice.current.hasSafeArea ? UIImage(named: "com_bg_girl") : UIImage(named: "com_bg_girl_short")
        view.addSubview(_commonBgImageView)
        _commonBgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    @objc func handlePublishAction() {
        debugPrint(" handlePublishAction Pressed ")
    }
    
    
}








