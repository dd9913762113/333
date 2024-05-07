//
//  DK_LottieTest.swift
//  3332323
//
//  Created by dd on 6/4/2023.
//  Copyright © 2023 XJW. All rights reserved.
//

import Foundation
import Lottie
import RxSwift

class DK_LottieTest: SportBaseVC {
    
    lazy var anminationView = LottieAnimationView(name: "cd_redpack").then { Image in
        Image.loopMode = .loop
        Image.backgroundBehavior = .pauseAndRestore
        Image.animationSpeed =  0.8
        Image.contentMode = .scaleAspectFill
    }
    
    let animationView1 = LottieAnimationView(
//        animation: Samples.animation(named: "Boat_Loader"),
        configuration: LottieConfiguration(renderingEngine: .mainThread)
    )
    
    lazy var startBtn: UIButton = {
        let startBtn = UIButton()
        startBtn.setTitle("start", for: .normal)
        startBtn.setTitleColor(UIColor.black, for: .normal)
        startBtn.titleLabel?.font = UIFont.pingFangRegular(16)
        startBtn.backgroundColor = R.Color.color_02a8a2
        startBtn.layer.cornerRadius = 6
        startBtn.layer.masksToBounds = true
        return startBtn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(anminationView)
        
        anminationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        self.view.addSubview(self.startBtn)
        self.startBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-80)
            make.width.height.equalTo(50)
        }
        
        startBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.anminationView.play()
        }).disposed(by: disposeBag)
        
//        cache.setAnimation(animation1, forKey: "animation1")
//        cache.setAnimation(animation1, forKey: "animation1")

    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}
