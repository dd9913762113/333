//
//  DownLoadTabbar.swift
//  3332323
//
//  Created by dd on 25/7/2021.
//

import Foundation
import UIKit


class DownLoadTabbar: UITabBarController {


    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpTabBar()
        
    }
    
    // MARK: - 控制器的信息
      func setUpTabBar() {
            
        let demo1VC  = DownLoadListVC()
        let demo2VC  = DownLoadVC()
       
          creatTabbarView(viewController: demo1VC, image: "mycity_normal", selectImage: "mycity_highlight", title: "下载列表")
          creatTabbarView(viewController: demo2VC, image: "mycity_normal", selectImage: "mycity_normal", title: "下载界面")
        
          
          self.tabBar.tintColor = UIColor(red: 255/255.0, green: 204/255.0, blue: 13/255.0, alpha: 1)
          self.tabBar.isTranslucent = false
              self.viewControllers = [
                  UINavigationController(rootViewController: demo1VC),
                  UINavigationController(rootViewController: demo2VC),
              ];
          
      }
      
      // MARK: - TabBar里面的文字图片
      func creatTabbarView(viewController:UIViewController, image:NSString, selectImage:NSString, title:NSString) {
          // alwaysOriginal 始终绘制图片原始状态，不使用Tint Color。
          viewController.tabBarItem.image = UIImage(named: image as String)?.withRenderingMode(.alwaysOriginal)
          viewController.tabBarItem.selectedImage = UIImage(named: selectImage as String)?.withRenderingMode(.alwaysOriginal)
          viewController.title = title as String
      }
    
}




extension UITabBarController {

    /// 返回当前的tabbarVC
    ///
    /// - Returns: 当前的TabBarVC?
    public func currentTabbarController() -> UITabBarController? {
        let window: UIWindow? = UIApplication.shared.appDelegateWindow
        let tabbarController: UIViewController? = window?.rootViewController
        if (tabbarController is UITabBarController) {
            return tabbarController as? UITabBarController
        }
        return nil
    }

    func hideTabBarShadowImageView() {
        tabBar.layoutIfNeeded()
//        let imgView = tabBar.tabShadowImageView()
//        imgView?.isHidden = true
//        imgView?.alpha = 0
//
//        //  去除 TabBar 阴影
//        if #available(iOS 13.0, *) {
//            let standardAppearance = UITabBarAppearance()
//            standardAppearance.shadowImage = UIImage()
//            standardAppearance.backgroundImage = UIImage()
//            standardAppearance.backgroundImageContentMode = .scaleToFill
//            standardAppearance.shadowColor = .clear
//            standardAppearance.backgroundColor = .clear
//            standardAppearance.backgroundEffect = nil
//            self.tabBar.standardAppearance = standardAppearance;
//        }
    }

}





extension UIApplication {

    var appDelegate: AppDelegate? {
        return (UIApplication.shared.delegate as? AppDelegate)
    }
    
    var appDelegateWindow: UIWindow? {
        return (UIApplication.shared.delegate as? AppDelegate)?.window
    }
    
    func visibleViewController(vc: UIViewController? = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController) -> UIViewController? {
        
        if let presented = vc?.presentedViewController {
            return visibleViewController(vc: presented)
        }
        if let tab = vc as? UITabBarController {
            if let selected = tab.selectedViewController {
                return visibleViewController(vc: selected)
            }
        }
        
        if let nav = vc as? UINavigationController {
            return visibleViewController(vc: nav.visibleViewController)
        }
        
        return vc
    }
    
    func topNavigationController(viewController: UIViewController? = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController) -> UINavigationController? {
        
        if let navigation = viewController as? UINavigationController {
            return navigation
        }
        
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topNavigationController(viewController: selected)
            }
        }
        
        if let presented = viewController?.presentedViewController {
            return topNavigationController(viewController: presented)
        }
        
        return viewController as? UINavigationController
    }
    
    func removeWindowObject(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.window?.rootViewController = nil
        delegate?.window?.subviews.forEach{
            $0.removeFromSuperview()
        }
        
    }
    
    //防重复替换
    static var isRepeatReplace = false
    func replaceRootViewController( _ vc: UIViewController, _ animated: Bool = true) {
        if UIApplication.isRepeatReplace {return}
        UIApplication.isRepeatReplace = true
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            UIApplication.isRepeatReplace = false
        }
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.window?.subviews.forEach{
            $0.removeFromSuperview()
        }
        if let viewController = delegate?.window?.rootViewController, viewController.presentedViewController != nil {
            viewController.dismiss(animated: false)
            changeRootViewController(vc, animated)
        }else {
            changeRootViewController(vc, animated)
        }
    }
    
    func changeRootViewController( _ vc: UIViewController, _ animated: Bool = true) {
        
        
        let animationView = UIScreen.main.snapshotView(afterScreenUpdates: false)
        
        //防止多重present不释放问题
        _ = dismiss(vc: UIApplication.shared.visibleViewController())
        
        self.appDelegateWindow?.addSubview(animationView)
        self.appDelegateWindow?.rootViewController = vc
        if animated {
            self.appDelegateWindow?.bringSubviewToFront(animationView)
            UIView.animate(withDuration: 0.25, animations: {
                animationView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                animationView.alpha = 0
            }, completion: { _ in
                animationView.removeFromSuperview()
            })
        } else {
            animationView.removeFromSuperview()
        }
        
    }
    
    func dismiss(vc: UIViewController?) -> UIViewController? {
        if let temp = vc?.presentingViewController {
            vc?.dismiss(animated: false, completion: nil)
            return dismiss(vc: temp)
        } else {
            return vc
        }
    }

}

extension UIApplication {
    
    func pushShareWebVC(urlString: String?) {
        guard let url = urlString else {
            return
        }
//        let webvc = LiveVideoWebDetailController(withShowNav: true)
//        webvc.url = URL(string: url)
//        webvc.hidesBottomBarWhenPushed = true
//        self.visibleViewController()?.navigationController?.pushViewController(webvc, animated: true)
    }
    
    /// 强制更新时使用
    /// - Parameter urlString: url字符串
    func  openURLByForceUpdate(urlString: String?) {
        openWebPage(urlString: urlString) { (isSuccess) in
            guard isSuccess else { return }
            DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                exit(0)
            })
        }
    }
    
    /// 用系统浏览器打开网页
    /// - Parameters:
    ///   - urlString: url字符串
    ///   - completionHandler: 是否成功的回调
    func openWebPage(urlString: String?, completionHandler: ((_ isSuccess: Bool) -> Void)? = nil) {
        guard let urlStr = urlString,
            let url = URL(string: urlStr) else {
                completionHandler?(false)
                return
        }
        openWebPage(url: url, completionHandler: completionHandler)
    }
    
    /// 用系统浏览器打开网页
    /// - Parameters:
    ///   - url: url
    ///   - completionHandler: 是否成功的回调
    func openWebPage(url: URL?, completionHandler: ((_ isSuccess: Bool) -> Void)? = nil) {
        guard let rURL = url,
            canOpenURL(rURL) else {
            completionHandler?(false)
            return
        }
        if #available(iOS 10, *) {
            open(rURL, options: [:], completionHandler: completionHandler)
        } else {
            openURL(rURL)
            completionHandler?(true)
        }
    }
}
