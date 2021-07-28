//
//  MediaPlay.swift
//  demo-iOS
//
//  Created by dd on 18/7/2021.
//  Copyright © 2021 kintan. All rights reserved.
//

import Foundation
import KSPlayer
import UIKit

class MediaPlay : UIViewController, PlayerControllerDelegate {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override var prefersStatusBarHidden: Bool {
        !playerView.isMaskShow
    }
    private let playerView = IOSVideoPlayerView()

    private let options = KSOptions()
    
    var videoURL : String? {
        didSet {
            guard let url = URL(string: self.videoURL ?? "") else { return }
            let options = KSOptions()
            options.isAutoPlay = true
            options.isSecondOpen = true
            options.isAccurateSeek = true
            options.isLoopPlay = true
            options.hardwareDecodeH265 = true
            options.hardwareDecodeH264 = true
            playerView.set(url: url, options: options)
            playerView.play()
        }
    }
    var resource: KSPlayerResource? {
        didSet {
            if let resource = resource {
                playerView.set(resource: resource)
                playerView.play()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initKSplayer()
        
        view.addSubview(playerView)
        playerView.delegate = self
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            playerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            playerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        view.layoutIfNeeded()
        playerView.backBlock = { [unowned self] in
            if UIApplication.shared.statusBarOrientation.isLandscape {
                self.playerView.updateUI(isLandscape: false)
            } else {
//                playerView.pause()
//                playerView.resetPlayer()
                self.navigationController?.popViewController(animated: true)
            }

        }
        playerView.becomeFirstResponder()

        debugPrint(" self.videoURL1  == ")
        debugPrint(self.videoURL as Any)
        debugPrint(" self.videoURL2 == " + String(describing:self.resource?.cover))

//        guard let url = URL(string: self.videoURL ?? "") else { return }
//        playerView.set(url: url, options: KSOptions())

    }
    
    private func initKSplayer()
    {
//        KSPlayerManager.canBackgroundPlay = true
        KSPlayerManager.logLevel = .error
        KSPlayerManager.firstPlayerType = KSMEPlayer.self
        KSOptions.isAutoPlay = true
        KSOptions.isSecondOpen = true
        KSOptions.isAccurateSeek = true
        KSOptions.isLoopPlay = true
        KSOptions.hardwareDecodeH265 = true
        KSOptions.hardwareDecodeH264 = true

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UIDevice.current.userInterfaceIdiom == .phone {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}



extension MediaPlay {
    func playerController(state: KSPlayerState) {

    }

    func playerController(currentTime: TimeInterval, totalTime: TimeInterval) {

    }

    func playerController(finish error: Error?) {

    }

    func playerController(maskShow: Bool) {
        setNeedsStatusBarAppearanceUpdate()
    }

    func playerController(action: PlayerButtonType) {

    }

    func playerController(bufferedCount: Int, consumeTime: TimeInterval) {

    }

}

//class MediaPlayView: VideoPlayerView {
//    override func customizeUIComponents() {
//        super.customizeUIComponents()
//        toolBar.isHidden = true
//        toolBar.timeSlider.isHidden = true
//    }
//
//    override open func player(layer: KSPlayerLayer, state: KSPlayerState) {
//        super.player(layer: layer, state: state)
//        if state == .readyToPlay, let player = layer.player {
//            print(player.naturalSize)
//            // list the all subtitles
//            let subtitleInfos = srtControl.filterInfos { _ in true }
//            subtitleInfos.forEach {
//                print($0.name)
//            }
//            subtitleInfos.first?.makeSubtitle { result in
//                self.resource?.subtitle = try? result.get()
//            }
//            for track in player.tracks(mediaType: .audio) {
//                print("audio name: \(track.name) language: \(track.language ?? "")")
//            }
//            for track in player.tracks(mediaType: .video) {
//                print("video name: \(track.name) bitRate: \(track.bitRate) fps: \(track.nominalFrameRate) bitDepth: \(track.bitDepth) colorPrimaries: \(track.colorPrimaries ?? "") colorPrimaries: \(track.transferFunction  ?? "") yCbCrMatrix: \(track.yCbCrMatrix ?? "") codecType:  \(track.codecType.string)")
//            }
//        }
//    }
//
//    override func onButtonPressed(type: PlayerButtonType, button: UIButton) {
//        if type == .landscape {
//            // xx
//        } else {
//            super.onButtonPressed(type: type, button: button)
//        }
//    }
//}


