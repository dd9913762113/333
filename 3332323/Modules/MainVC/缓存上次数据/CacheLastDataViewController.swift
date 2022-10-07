//
//  CacheLastDataViewController.swift
//  3332323
//
//  Created by dd on 1/10/2022.
//  Copyright © 2022 XJW. All rights reserved.
//

import Foundation
import Alamofire
import DaisyNet
import UIKit

class CacheLastDataViewController: SportBaseVC {
    
     
    private lazy var textView: UITextView = {
        let ipsView = UITextView()
        ipsView.tintColor = #colorLiteral(red: 0.3803921569, green: 0.8117647059, blue: 0.7803921569, alpha: 1)
        ipsView.font = UIFont.pingFangRegular(16)
        ipsView.textColor = .black
        ipsView.backgroundColor = UIColor.white.withAlphaComponent(0.32)
        ipsView.layer.borderColor = UIColor.black.cgColor
        ipsView.layer.borderWidth = 1
        ipsView.layer.cornerRadius = 5
        ipsView.layer.masksToBounds = true
//        ipsView.delegate = self
//        ipsView.returnKeyType = .done
//        ipsView.text = ""
        return ipsView
    }()
    
    private lazy var cacheTextView: UITextView = {
        let ipsView = UITextView()
        ipsView.tintColor = #colorLiteral(red: 0.3803921569, green: 0.8117647059, blue: 0.7803921569, alpha: 1)
        ipsView.font = UIFont.pingFangRegular(16)
        ipsView.textColor = .black
        ipsView.backgroundColor = UIColor.white.withAlphaComponent(0.32)
        ipsView.layer.borderColor = UIColor.black.cgColor
        ipsView.layer.borderWidth = 1
        ipsView.layer.cornerRadius = 5
        ipsView.layer.masksToBounds = true
//        ipsView.delegate = self
//        ipsView.returnKeyType = .done
//        ipsView.text = "www.baidu.com"
        return ipsView
    }()

    private lazy var startBtn : UIButton = {
        let startBtn = UIButton()
        startBtn.setTitle("start", for: .normal)
        startBtn.setTitleColor(UIColor.black, for: .normal)
        startBtn.titleLabel?.font = UIFont.pingFangRegular(16)
        startBtn.backgroundColor = R.Color.color_02a8a2
        startBtn.layer.cornerRadius = 6
        startBtn.layer.masksToBounds = true
        return startBtn
    }()
    
    
    let urlStr = "https://api.snaptubebrowser.com/surf-api/content/guide/v2"
    let params: [String: Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.getHttpData()
       
    }
    
    
//    make.top.equalTo(ipsView.snp.bottom).offset(12)
//    make.left.equalToSuperview().offset(12)
//    make.width.equalTo(45)
//    make.height.equalTo(30)
    func setUpUI() {
//        view.insertSubview(textView, aboveSubview: view)
//        view.insertSubview(cacheTextView, aboveSubview: view)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "开始", style: .plain, target: self, action: #selector(rightPressed))

        self.view.addSubview(textView)
        self.view.addSubview(cacheTextView)

        textView.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(15 + kNavigationBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        
        cacheTextView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(50)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
//        textView.backgroundColor = .red
//        cacheTextView.backgroundColor = .orange
//
//
//        startBtn.rx.tap.subscribe(onNext: { _ in
//
//        }).disposed(by: self.disposeBag)
        startBtn.rx.tap
            .subscribe(onNext: { [weak self]  in
                guard let self = self else { return }
                print(" startBtn Pressed")
            })
            .disposed(by: self.disposeBag)

    }
    
    @objc func rightPressed (){
        getHttpData()
    }
    
    
    func getHttpData () {
        DaisyNet.openResultLog = true
        /// 20s过期
        DaisyNet.cacheExpiryConfig(expiry: DaisyExpiry.seconds(20))
        /// 10s超时
        DaisyNet.timeoutIntervalForRequest(10)

        DaisyNet.request(urlStr, params: params).cache(true).responseCacheAndString(queue: .main) { value in
            switch value.result {
            case .success(let string):
                print(Thread.current)
                if value.isCacheData {
                    self.cacheTextView.text = string
                } else {
                    self.textView.text = string
                }

            case .failure(let error):
                print(error)
            }
        }
    }
    
    func clearCache(_ sender: UIBarButtonItem) {
        DaisyNet.removeObjectCache(urlStr, params: params) { success in
            switch success {
            case true:
                self.cacheTextView.text = ""
            case false:
                print("false")
            }
        }
    }

    deinit {
        print("dealloc =========== \(self)")
    }
    
}
        
        
