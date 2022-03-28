//
//  PINGTest.swift
//  3332323
//
//  Created by dd on 28/3/22.
//  Copyright © 2022 XJW. All rights reserved.
//

import Foundation
import SwiftUI

class PINGTest: UIViewController, UITextViewDelegate {
    
    var ipsView : UITextView!
    var pingResultView : UITextView!
//    var periodTextField : UITextField!
//    var timeoutTextField : UITextField!
    var timeout : TimeInterval = 1
    var period : TimeInterval = 1
    

    
    private lazy var periodTextField : UITextField = {
        let periodTextField = UITextField()
        periodTextField.font = UIFont.pingFangRegular(16)
        periodTextField.placeholder =  "时间"
        periodTextField.textColor = UIColor.black
        periodTextField.textAlignment = .center
        periodTextField.backgroundColor = R.Color.color_02a8a2
//        periodTextField.layer.borderColor = UIColor.black.cgColor
//        periodTextField.layer.borderWidth = 1
        periodTextField.layer.cornerRadius = 5
        periodTextField.layer.masksToBounds = true

        return periodTextField
    }()
    private lazy var timeoutTextField : UITextField = {
        let timeoutTextField = UITextField()
        timeoutTextField.font = UIFont.pingFangRegular(16)
        timeoutTextField.placeholder =  "次数"
        timeoutTextField.textColor = UIColor.black
        timeoutTextField.textAlignment = .center
        timeoutTextField.backgroundColor = R.Color.color_02a8a2

//        timeoutTextField.layer.borderColor = UIColor.black.cgColor
//        timeoutTextField.layer.borderWidth = 1
        timeoutTextField.layer.cornerRadius = 5
        timeoutTextField.layer.masksToBounds = true
        return timeoutTextField
    }()
    
    private lazy var startBtn : UIButton = {
        let startBtn = UIButton()
        startBtn.setTitle("start", for: .normal)
        startBtn.setTitleColor(UIColor.black, for: .normal)
        startBtn.titleLabel?.font = UIFont.pingFangRegular(16)
        startBtn.backgroundColor = R.Color.color_02a8a2
        startBtn.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        startBtn.layer.cornerRadius = 6
        startBtn.layer.masksToBounds = true
        return startBtn
    }()
    
    private lazy var stopBtn : UIButton = {
        let stopBtn = UIButton()
        stopBtn.setTitle("stop", for: .normal)
        stopBtn.setTitleColor(UIColor.black, for: .normal)
        stopBtn.titleLabel?.font = UIFont.pingFangRegular(16)
        stopBtn.backgroundColor = R.Color.color_02a8a2
        stopBtn.addTarget(self, action: #selector(stopAction), for: .touchUpInside)
        stopBtn.layer.cornerRadius = 6
        stopBtn.layer.masksToBounds = true
        return stopBtn
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _setMainView()
      
//        let ping = Ping()
//        ping.delegate = self
//        ping.host = "www.baidu.com"
//        PingMannager.shared.setup {
//            PingMannager.shared.timeout = 1
//            PingMannager.shared.pingPeriod = 0.2
//            PingMannager.shared.startPing()
//            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1.4, execute: {
//                if PingMannager.shared.isPinging{
//                    PingMannager.shared.stopPing()
//                }
//            })
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute:
        {
            self.testNENPingManager()
        })
    }
    
    func _setMainView() {
        view.backgroundColor = .white
        ipsView = UITextView()
//        ipsView.text = (lastContent.value as String?) ?? "https://github.com/EFPrefix/EFQRCode"
        ipsView.tintColor = #colorLiteral(red: 0.3803921569, green: 0.8117647059, blue: 0.7803921569, alpha: 1)
        ipsView.font = UIFont.pingFangRegular(16)
        ipsView.textColor = .black
        ipsView.backgroundColor = UIColor.white.withAlphaComponent(0.32)
        ipsView.layer.borderColor = UIColor.black.cgColor
        ipsView.layer.borderWidth = 1
        ipsView.layer.cornerRadius = 5
        ipsView.layer.masksToBounds = true
        ipsView.delegate = self
        ipsView.returnKeyType = .done
        ipsView.text = "www.baidu.com"
        
        pingResultView = UITextView()
//        ipsView.text = (lastContent.value as String?) ?? "https://github.com/EFPrefix/EFQRCode"
        pingResultView.tintColor = #colorLiteral(red: 0.3803921569, green: 0.8117647059, blue: 0.7803921569, alpha: 1)
        pingResultView.font = UIFont.pingFangRegular(16)
        pingResultView.textColor = .black
        pingResultView.backgroundColor = UIColor.white.withAlphaComponent(0.32)
        pingResultView.layer.borderColor = UIColor.black.cgColor
        pingResultView.layer.borderWidth = 1
        pingResultView.layer.cornerRadius = 5
        pingResultView.layer.masksToBounds = true
        pingResultView.delegate = self
        pingResultView.returnKeyType = .done
       
        view.insertSubview(ipsView, aboveSubview: view)
        view.insertSubview(periodTextField, aboveSubview: view)
        view.insertSubview(timeoutTextField, aboveSubview: view)
        view.insertSubview(startBtn, aboveSubview: view)
        view.insertSubview(stopBtn, aboveSubview: view)
        view.insertSubview(pingResultView, aboveSubview: view)

        ipsView.snp.makeConstraints {(make) in
            make.top.equalToSuperview().offset(15 + kNavigationBarHeight)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(100)
        }
        periodTextField.snp.makeConstraints {(make) in
            make.top.equalTo(ipsView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        timeoutTextField.snp.makeConstraints {(make) in
            make.top.equalTo(ipsView.snp.bottom).offset(12)
            make.left.equalTo(periodTextField.snp.right).offset(15)
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        
        stopBtn.snp.makeConstraints {(make) in
            make.top.equalTo(ipsView.snp.bottom).offset(12)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(46)
            make.height.equalTo(30)
        }
        startBtn.snp.makeConstraints {(make) in
            make.top.equalTo(ipsView.snp.bottom).offset(12)
            make.right.equalTo(stopBtn.snp.left).offset(-15)
            make.width.equalTo(46)
            make.height.equalTo(30)
        }
       
        pingResultView.snp.makeConstraints {(make) in
            make.top.equalTo(ipsView.snp.bottom).offset(45)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalTo(view.snp.bottom).offset(-34)
        }
        
        
        ipsView.layer.borderColor = UIColor.black.cgColor
        ipsView.layer.borderWidth = 1
        pingResultView.layer.borderColor = UIColor.black.cgColor
        pingResultView.layer.borderWidth = 1
        periodTextField.text = period.description
        timeoutTextField.text = timeout.description
        
    }
    
    
    
    
    @objc func stopAction(){
        PingManager.shared.stopPing()
    }
    @objc func startAction(){
        let ipContent = ipsView.text
        if let ipArray = ipContent?.components(separatedBy: ","){
            for ip in ipArray{
                let ping = Ping()
                ping.delegate = self
                ping.host = ip
                PingManager.shared.add(ping)
            }
        }
        self.timeout = TimeInterval(self.timeoutTextField.text ?? self.timeout.description)!
        self.period = TimeInterval(self.periodTextField.text ?? self.period.description)!
        let timeout = self.timeout
        let period = self.period
        PingManager.shared.setup {
            $0.timeout = timeout
            $0.pingPeriod = period
            $0.startPing()
        }
        
    }
    
  
    func testNENPingManager()  {
        let hostArray = ["www.bilibili.com",
                         "www.baidu.com",
                         "www.youku.com",
                         "www.gg.com",
                         "www.123.com",
                         "www.hao123.com"
                                   ];
        
        DK_NENPingTest.shared().startHostPing(withTime: 1, hostArray: hostArray) { hostName, sortedAddress in
            
        }
        

    }
    
  
    
    
}


extension PINGTest : PingDelegate{
    func stop(_ ping: Ping) {
        
    }
    
    func ping(_ pinger: Ping, didFailWithError error: Error) {
        
    }
    func ping(_ pinger: Ping, didTimeoutWith result: PingResult) {
        pingResult(result)
    }
    func ping(_ pinger: Ping, didReceiveReplyWith result: PingResult) {
        pingResult(result)
    }
    func ping(_ pinger: Ping, didReceiveUnexpectedReplyWith result: PingResult) {
        pingResult(result)
    }
    func pingResult(_ result:PingResult){
        var resultString = ""
        if result.pingStatus == .success{
            resultString = "Host:\(result.host ?? "") ttl:\(result.ttl) time:\(Int(result.time * 1000))"
        }else{
            resultString = "Host:\(result.host ?? "") failed"
        }
        DispatchQueue.main.async {
            let oldString = self.pingResultView.text ?? ""
            self.pingResultView.text = resultString + "\n" + oldString
        }
        
    }
    
}
extension PINGTest : UITextFieldDelegate{
    
}
