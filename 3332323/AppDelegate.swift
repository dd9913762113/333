//
//  AppDelegate.swift
//  3332323
//
//  Created by dd on 9/7/2021.
//

import UIKit
import PushKit
import SwiftMediator
import JitsiMeetSDK
import XYNav

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
//    lazy var manager: AppDelegateManager = {
//         return AppDelegateManager.init(delegates: [AppDe.init(window)])
//     }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = BaseTabbarController()
     
//        sleep(30)
        
//        manager.application(application, didFinishLaunchingWithOptions: launchOptions)

       
        self.voipRegistration()        
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        self.window = window
        return true

        guard let launchOptions = launchOptions else { return false }
        JitsiMeet.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {

        DownloadManager.shared.downloadBackground(application, handleEventsForBackgroundURLSession: identifier) {
            
        }
    }

    // MARK: - Linking delegate methods
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return JitsiMeet.sharedInstance().application(application, continue: userActivity, restorationHandler: restorationHandler)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return JitsiMeet.sharedInstance().application(app, open: url, options: options)
    }
}


private enum DownloadFileError {
    case network
}

private func downloadHTTPData(url: URL) -> Signal<Data, DownloadFileError> {
    return Signal { subscriber in
        let completed = Atomic<Bool>(value: false)
        let downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { location, _, error in
            let _ = completed.swap(true)
            if let location = location, let data = try? Data(contentsOf: location) {
                subscriber.putNext(data)
                subscriber.putCompletion()
            } else {
                subscriber.putError(.network)
            }
        })
        downloadTask.resume()

        return ActionDisposable {
            if !completed.with({ $0 }) {
                downloadTask.cancel()
            }
        }
    }
}





/**
 
 https://github.com/dd9913762113/sources/blob/main/s/images/87040bb.png?raw=true
 
 https://github.com/dd9913762113/sources/blob/main/s/images/ss/IMG_0003.JPG?raw=true


 /Users/dd/Documents/GitHub/TestSwift/3332323.xcodeproj: Missing package product 'V2exAPI'


 
 */
