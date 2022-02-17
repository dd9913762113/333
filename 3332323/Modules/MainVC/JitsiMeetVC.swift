//
//  JitsiMeetVC.swift
//  3332323
//
//  Created by dd on 17/2/22.
//

import Foundation
import JitsiMeetSDK

class JitsiMeetVC: SportBaseVC {

    private lazy var videoButton : UIButton = {
        let videoButton = UIButton()
        videoButton.setTitle("参加", for: .normal)
        videoButton.setTitleColor(UIColor.init(hex: "#FFFFFF"), for: .normal)
        videoButton.titleLabel?.font = UIFont.pingFangRegular(16)
        videoButton.backgroundColor = R.Color.color_02a8a2
        videoButton.addTarget(self, action: #selector(loginOutBtnPressed), for: .touchUpInside)
        videoButton.layer.cornerRadius = 6
        videoButton.layer.masksToBounds = true
        return videoButton
    }()
    
    private lazy var roomName : UITextField = {
        let roomName = UITextField()
        roomName.font = UIFont.pingFangRegular(16)
        roomName.placeholder =  "请输入房间名称"
        roomName.textColor = UIColor.lightGray
        return roomName
    }()
    
    
    fileprivate var jitsiMeetView: JitsiMeetView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultOptions = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            // for JaaS replace url with https://8x8.vc
//            builder.serverURL = URL(string: "https://meet.jit.si")
            builder.serverURL = URL(string: "https://ado.douyinren.com")

        
            // for JaaS use the obtained Jitsi JWT
            // builder.token = "SampleJWT"
            builder.setFeatureFlag("welcomepage.enabled", withValue: false)
            // Set different feature flags
            //builder.setFeatureFlag("toolbox.enabled", withBoolean: false)
            //builder.setFeatureFlag("filmstrip.enabled", withBoolean: false)
        }
        
        JitsiMeet.sharedInstance().defaultConferenceOptions = defaultOptions
        
        _setMainView()
    }
    
    
    private func _setMainView() {
        
        view.insertSubview(roomName, aboveSubview: view)
        view.insertSubview(videoButton, aboveSubview: view)
        
        roomName.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-50)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(20)
        }
        
        videoButton.snp.makeConstraints { (make) in
            make.top.equalTo(roomName.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(44)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    @objc public func loginOutBtnPressed() {
        SOUT("")
        let room: String = roomName.text!
        if(room.count < 1) {
            return
        }
        
        // create and configure jitsimeet view
        let jitsiMeetView = JitsiMeetView()
        jitsiMeetView.delegate = self
        self.jitsiMeetView = jitsiMeetView
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            // for JaaS use <tenant>/<roomName> format
            builder.room = room
            // Settings for audio and video
            // builder.audioMuted = true;
            // builder.videoMuted = true;
        }
                
        // setup view controller
        let vc = UIViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.view = jitsiMeetView
        
        // join room and display jitsi-call
        jitsiMeetView.join(options)
        present(vc, animated: true, completion: nil)
        
    }
    
    fileprivate func cleanUp() {
        if(jitsiMeetView != nil) {
            dismiss(animated: true, completion: nil)
            jitsiMeetView = nil
        }
    }

}


extension JitsiMeetVC: JitsiMeetViewDelegate {
    func ready(toClose data: [AnyHashable : Any]!) {
        cleanUp()
    }
}
