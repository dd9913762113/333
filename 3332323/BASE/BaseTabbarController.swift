//
//  BaseTabbarController.swift
//  3332323
//
//  Created by dd on 25/1/22.
//

import Foundation
import UIKit
import XYNav
import AttributedString

fileprivate typealias ChildVcType = (chaildVC: UIViewController, title: String, selectImgName: String, normalImgName: String)
//public final class BaseTabbarController: UITabBarController, UITabBarControllerDelegate, JFPopupAnimationProtocol {
public final class BaseTabbarController: UITabBarController, UITabBarControllerDelegate {

  
    static func shared() -> BaseTabbarController {
        struct SingleStruct {
            static var single = BaseTabbarController()
        }
        return SingleStruct.single
    }
//    var myConfig = Config()
    
    
    
    deinit {
        SOUT("\(type(of: self))控制器被释放了")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        _addChildVcs()
//        getMainConfigOrUpdate(isUpdate: true)
    }
    
    public override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
        _setupUI()
     }
    
    private func _setupUI() {
//        tabBar.isTranslucent = true
        tabBar.shadowImage = nil
        tabBar.tintColor = R.Color.tabSelect
        tabBar.unselectedItemTintColor = R.Color.tabNormal
        tabBar.backgroundColor = .clear
        tabBar.backgroundImage = UIImage(named: "tab_bg")
        
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .clear
            appearance.backgroundColor = .clear
            appearance.backgroundImage = UIImage(named: "tab_bg")
            appearance.backgroundImageContentMode = .scaleToFill
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: R.Color.tabNormal]
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: R.Color.tabSelect]
            tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            }
        } else {
            if let lineView = tabBar.subviews.first?.subviews[safe: 1] as? UIImageView {
                lineView.isHidden = true
            }
            if let imageView = tabBar.subviews.first?.subviews[safe: 0] as? UIImageView {
                imageView.contentMode = .scaleAspectFill
            }
        }
    }
    
    private func _addChildVcs() {
        let vcs: [ChildVcType] = [
            (HomeVC(), "首页", "icon_main_selected", "icon_main"),
            (LiveVC(), "开播", "icon_liveing_selected", "icon_liveing"),
            (FollowVC(), "关注", "icon_follow_selected", "icon_follow"),
//            (TheNewsViewController(), "新闻", "icon_follow_selected", "icon_follow"),
            (MainVC(), "分部", "icon_main_selected", "icon_main"),
            (MineVC(), "我的", "icon_mine_selected", "icon_mine")
        ]
        
        vcs.forEach {
//            let naviVc = SportBaseNavController(rootViewController: $0.chaildVC)
//            top_back
            let naviVc = XYNavigationController(rootViewController: $0.chaildVC)
//            naviVc.backImage
            naviVc.tabBarItem.selectedImage = UIImage(named: $0.selectImgName)?.withRenderingMode(.alwaysOriginal)
            naviVc.tabBarItem.image = UIImage(named: $0.normalImgName)?.withRenderingMode(.alwaysOriginal)
            naviVc.title = $0.title
            addChild(naviVc)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    public func getMainConfigOrUpdate(isUpdate : Bool) {
//        NetService.config().done { config in
//            SOUT("config \(config)")
//            self.myConfig = config
//                let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
//                let newVersion =  self.compareVersion(nowVersion: appVersion, newVersion: config.version_ios)
//                if newVersion {
//                    SOUT("更新版本")
//                    self.showAnimationView()
//                }else{
////                    self.showAnimationView()
//                }
//
//        }.catch { err in
//            SOUT(err)
//        }
//    }
//
//        @objc public func showOpenSafariURL(urlString : String) {
//            if urlString.hasPrefix("http") {
//                guard let url = URL(string: urlString) else { return }
//                UIApplication.shared.open(url, options: [:]) { success in
//                }
//            }else{
//                if myConfig.dl_web_url.hasPrefix("http") {
//                    guard let url = URL(string: myConfig.dl_web_url) else { return }
//                    UIApplication.shared.open(url, options: [:]) { success in }
//                }
//            }
//        }
//
//    @objc public func showOpenSafari () {
//        self.showOpenSafariURL(urlString: myConfig.dl_web_url)
//    }
//
//
//    func compareVersion(nowVersion:String,newVersion:String) -> Bool {
//            let nowArray = nowVersion.split(separator: ".")
//            let newArray = newVersion.split(separator: ".")
//            let big = nowArray.count > newArray.count ? newArray.count : nowArray.count
//            for index in 0...big - 1 {
//
//                let first = nowArray[index]
//                let second = newArray[index]
//                if Int(first)! < Int(second)!  {
//                    return true
//                }
//            }
//            return false
//        }
//
//    public func present(with transitonContext: UIViewControllerContextTransitioning?, config: JFPopupConfig, contianerView: UIView, completion: ((Bool) -> ())?) {
//        var contianerView = contianerView
//        contianerView.frame.origin.y = -contianerView.jf.height
//        contianerView.jf.centerX = CGSize.jf.screenWidth() / 2
//        contianerView.layoutIfNeeded()
//        UIView.animate(withDuration: 0.25, animations: {
//            contianerView.jf.centerY = CGSize.jf.screenHeight() / 2
//            contianerView.layoutIfNeeded()
//        }) { (finished) in
//            transitonContext?.completeTransition(true)
//            completion?(finished)
//        }
//    }
//
//    public func dismiss(with transitonContext: UIViewControllerContextTransitioning?, config: JFPopupConfig, contianerView: UIView?, completion: ((Bool) -> ())?) {
//        guard let contianerView = contianerView else {
//            transitonContext?.completeTransition(true)
//            completion?(false)
//            return
//        }
//        UIView.animate(withDuration: 0.25, animations: {
//            contianerView.superview?.alpha = 0
//            contianerView.frame.origin.y = -contianerView.jf.height
//            contianerView.layoutIfNeeded()
//        }) { (finished) in
//            transitonContext?.completeTransition(true)
//            completion?(finished)
//        }
//    }
//
//    func showAnimationView() {
//        var config = JFPopupConfig.dialog
//        config.bgColor = UIColor.hexWithAlpha(hex: "#333333", alpha: 0.3)
//        let vc = JFPopupController(with: config, popupProtocol: self) { [self] in
//            let imageV :UIImageView = {
//                let imageV = UIImageView(frame: CGRect(x: (kScreenW-267)/2, y: (kScreenH-311)/2 , width: 267, height: 311))
//                imageV.image = UIImage(named: "updateImage")
//                imageV.isUserInteractionEnabled = true
//
//                let btn23 = UIButton(type: .custom)
//                btn23.frame = CGRect(x: 45, y: 250, width: 175, height: 36)
//                btn23.setTitle("立即更新", for: .normal)
//                btn23.titleLabel?.font = UIFont.pingFangRegular(12)
//                btn23.backgroundColor = R.Color.color_02a8a2
//                btn23.setTitleColor(UIColor.white, for: .normal)
//                btn23.layer.cornerRadius = 6;
//                btn23.addTarget(self, action: #selector(self.showOpenSafari), for: .touchUpInside)
//                imageV.addSubview(btn23)
//
//                return imageV
//            }()
//            return imageV
//        }
//        vc.show(with: self)
//    }



}

