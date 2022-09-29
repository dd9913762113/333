//
//  TimerDemoViewController.swift
//  3332323
//
//  Created by dd on 29/9/2022.
//  Copyright © 2022 XJW. All rights reserved.
//

import Foundation

class TimerDemoViewController: UIViewController {
    
    var currentCount = 0
    
    var gcdTimer: DispatchSourceTimer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        testGCD()
        TimerManager.instance.schedule(timerKey: self.theClassName, targat: self, selector: #selector(test))

    }
    
    func testGCD() {
        let queue = DispatchQueue.global()
        self.gcdTimer = DispatchSource.makeTimerSource(queue: queue)
        
//        self.gcdTimer?.schedule(wallDeadline: DispatchWallTime.now(), repeating: 1)
        self.gcdTimer?.schedule(deadline: DispatchTime.now(), repeating: 1)
        self.gcdTimer?.setEventHandler { [weak self] in
            self?.test()
        }
        self.gcdTimer?.resume()
    }
    
    @objc func test() {
        if CacheManager.instance.hasCachedValue(with: self.theClassName) {
            if let cacheDate = CacheManager.instance.valueWithCache(key: self.theClassName) as? NSDate {
                if cacheDate.timeIntervalSinceNow < -2 {
                    ///因为时间差是负数 如果是倒计时 就加上时间差 反之则减去时间差
                    self.currentCount -= Int(cacheDate.timeIntervalSinceNow) + 1
                }
            }
        }
        CacheManager.instance.cacheData(NSDate(), withKey: self.theClassName)

        currentCount += 1
        print(currentCount)
    }
    
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil

        self.link?.invalidate()
        self.link = nil

        self.gcdTimer?.cancel()

        TimerManager.instance.cancelTask(timerKey: self.theClassName)

        print("deinit \(self.theClassName)")
    }
    
}

public extension NSObject {
    var theClassName: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last ?? ""
    }
}


