//
//  Global.swift
//  3332323
//
//  Created by dd on 25/1/22.
//

import Foundation
import UIKit

@_exported import RxSwift
@_exported import RxCocoa
@_exported import KakaJSON
@_exported import Toast_Swift
@_exported import Alamofire
@_exported import PromiseKit
@_exported import SnapKit
@_exported import TangramKit
@_exported import AttributedString
@_exported import Then
@_exported import FSPagerView
@_exported import TXScrollLabelView
@_exported import JXSegmentedView
@_exported import SafariServices

//@_exported import SwiftSignalKit


// MARK: - Macro
var MainUrl:String { get { return domainName }}
var domainName = "https://sport.sun8tv.com/api/"

// MARK: - 通用尺寸
/// 屏幕宽度
public let kScreenW = UIScreen.main.bounds.width
/// 屏幕高度
public let kScreenH = UIScreen.main.bounds.height
/// 状态栏高度
public let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
/// navBar高度
public let kNavBarHeight: CGFloat = 44
/// tabbar高度
public let kTabBarHeight: CGFloat = 54
/// iPhoneX额外顶部高度
public let kExTForIPX: CGFloat = (isIPhoneXSeries ? (kStatusBarHeight - 20) : 0)
/// iPhoneX额外底部高度
public let kExBForIPX: CGFloat = (isIPhoneXSeries ? 34.0 : 0)
/// iPhoneX额外高度
public let kExHForIPX: CGFloat  = (isIPhoneXSeries ? (kExTForIPX + kExBForIPX): 0)
/// iPhone (navBar高度 + statusBar高度)
public let kTopHeight: CGFloat = kNavBarHeight + kStatusBarHeight
/// iPhone (tabBar高度 + 额外底部高度)
public let kBottomHeight: CGFloat = kTabBarHeight + kExBForIPX
/// iPhone 通用内容高度（总高度-kTopHeight-kBottomHeight）
public let kContentHeight: CGFloat = kScreenH - kTopHeight - kBottomHeight
/// iPhone 通用内容Frame
public let kContentFrame: CGRect = CGRect.init(x: 0, y: 0, width: kScreenW, height: kContentHeight)

// MARK: - 设备信息
/// 当前app信息
public let AppInfo = Bundle.main.infoDictionary
/// 当前app名字
public let AppName = AppInfo?["CFBundleName"] as? String ?? ""
/// 当前app BundleIdentifier
public let AppBundleID = AppInfo?["CFBundleIdentifier"] as? String ?? ""
/// 当前app Version
public let AppVersion = AppInfo?["CFBundleShortVersionString"] as? String ?? ""
/// 当前app  Build number
public let AppBuildVersion = AppInfo?["CFBundleVersion"] as? String ?? ""
/// 获取设备系统号
public let SystemVersion = UIDevice.current.systemVersion
/// iPhone设备
public let isIPhone = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? true : false)
/// iPad设备
public let isIPad = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? true : false)
/// iPod设备
public let isIPod = (UIDevice.current.model == "iPod touch" ? true : false)
/// iPhone4设备
public let isIPhone4 = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) < 568.0 ? true : false)
/// iPhone5设备
public let isIPhone5 = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 568.0 ? true : false)
/// iPhone6/6s设备
public let isIPhone6_6s = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 667.0 ? true : false)
/// iPhone6Plus/6sPlus设备
public let isIPhone6P = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 736.0 ? true : false)
/// 是否iPhoneX系列
public let isIPhoneXSeries = (UIApplication.shared.statusBarFrame.size.height >= 40 ? true : false)

// MARK: - Function
/// 屏幕适配-以屏幕宽度为缩放标准
public func PX(_ value : CGFloat) -> CGFloat {
    return ((value * (kScreenW / (750.0 / 2.0))) / 2).intValue.CGFloatValue  // (ScreenW / (750.0 / 2.0))是缩放比例  UI默认给的6s图 是750.0/2.0
}

/// 屏幕适配-以屏幕高度为缩放标准
public func PY(_ value : CGFloat) -> CGFloat {
    return ((isIPhoneXSeries ? (value * (kScreenH / (2436.0 / 3.0))) : (value * (kScreenH / (1334.0 / 2.0)))) / 2).intValue.CGFloatValue  // (ScreenW / (1334.0 / 2.0))是缩放比例  UI默认给的6s图 是1334.0/2.0
}

public func SOUT<T>(_ msg: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
    if "\(msg)".contains("\n") {
        print("\(formatter.string(from: Date()))文件:\((file as NSString).pathComponents.last ?? "")[\(line)行] 方法:\(method) > \n\(msg)")
    } else {
        print("\(formatter.string(from: Date()))文件:\((file as NSString).pathComponents.last ?? "")[\(line)行] 方法:\(method) > \(msg)")
    }
    #endif
}

fileprivate let formatter = { () -> DateFormatter in
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS "
    return formatter
}()

postfix func ++(x: inout Int) {
    x += 1
}

postfix func --(x: inout Int) {
    x -= 1
}


public let SPACE: CGFloat = 15
public let PAGEZIE = 20

// MARK: - Toast
public let defaultToastTime: TimeInterval = 1.5

public func showMessage(_ message: String, _ duration: TimeInterval = defaultToastTime) {
    ToastManager.shared.style.cornerRadius = 6
    UIApplication.shared.keyWindow?.hideToast()
    UIApplication.shared.keyWindow?.makeToast(message, duration: duration, point: CGPoint.init(x: kScreenW / 2, y: kScreenH * (1 - 0.618)), title: nil, image: nil, completion: nil)
}

public func showMessage(message: String, duration: TimeInterval, messageAlignment: NSTextAlignment = .left) {
    ToastManager.shared.style.messageAlignment = messageAlignment
    showMessage(message, duration)
}

public func showProgress() {
    UIApplication.shared.keyWindow?.makeToastActivity(.center)
}

public func hideProgress() {
    UIApplication.shared.keyWindow?.hideToastActivity()
}

public func showGlobleMessage(_ message: String) {
    showMessage(message)
}

// MARK: - jump web
public enum JumpWebType {
//    case InternalSafari
    case InternalWkWebView
    case External
}

public enum JumpType {
    case Present
    case Push
}

public func showUrl(_ urlStr: String,
                    _ type: JumpWebType = .InternalWkWebView,
                    _ customTitle: String? = nil,
                    _ jumpType: JumpType = .Push) {
    if let url = urlStr.urlEncoded().urlValue {
        var vc: UIViewController?
        switch type {
//        case .InternalSafari:
//            vc = SFSafariViewController(url: url)
        case .InternalWkWebView:
            let webvc = BaseWebController()
            webvc.titleText = customTitle ?? ""
            webvc.url = urlStr
            vc = SportBaseNavController(rootViewController: webvc)
        case .External:
            UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey : Any](), completionHandler: nil)
        }
        if let curVc = vc {
            switch jumpType {
            case .Present:
                UIApplication.shared.keyWindow?.rootViewController?.present(curVc.then { $0.modalPresentationStyle = .fullScreen }, animated: true, completion: nil)
            case .Push:
                if let curVc = (curVc as? SportBaseNavController)?.children.first {
                    currNavigationController().pushViewController(curVc, animated: true)
                } else {
                    currNavigationController().pushViewController(curVc, animated: true)
                }
            }
        }
    } else {
//        showMessage("链接\(urlStr)加载失败")
    }
    
}


var isFullScreen: Bool {
    if #available(iOS 11, *) {
        guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
            return false
        }
          
          if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
              print(unwrapedWindow.safeAreaInsets)
              return true
          }
    }
    return false
}

var kNavigationBarHeight: CGFloat {
   //return UIApplication.shared.statusBarFrame.height == 44 ? 88 : 64
   return isFullScreen ? 88 : 64
}
    
var kBottomSafeHeight: CGFloat {
   //return UIApplication.shared.statusBarFrame.height == 44 ? 34 : 0
   return isFullScreen ? 34 : 0
}

var kNavigationstausBarHeight: CGFloat {
   //return UIApplication.shared.statusBarFrame.height == 44 ? 88 : 64
   return isFullScreen ? 44 : 20
}
