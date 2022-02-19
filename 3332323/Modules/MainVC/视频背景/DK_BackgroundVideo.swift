//
//  DK_BackgroundVideo.swift
//  3332323
//
//  Created by dd on 19/2/22.
//  Copyright © 2022 XJW. All rights reserved.
//

import Foundation


class DK_BackgroundVideo: SportBaseVC {
    
    var backgroundPlayer : BackgroundVideo?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundPlayer = BackgroundVideo(on: self, withVideoURL: "login_bg.mp4")
        backgroundPlayer?.setUpBackground()
        
        
        
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    
}
