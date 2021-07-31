//
//  UIDevice+Extension.swift
//  3332323
//
//  Created by dd on 31/7/2021.
//

import Foundation

import UIKit
import AdSupport

extension UIDevice {
   
    var hasSafeArea: Bool {
        guard #available(iOS 11.0, *) else {
            return false
        }
        return UIApplication.shared.windows[0].safeAreaInsets != UIEdgeInsets.zero
    }
    
    func safeTop() -> CGFloat {
        guard #available(iOS 11.0, *) else {
            return 0
        }
        return UIApplication.shared.windows[0].safeAreaInsets.top
    }
    
    
    
    
    static let deviceType: DeviceType = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPhone5,1", "iPhone5,2":
            return .iPhone5
        case "iPhone5,3", "iPhone5,4":
            return .iPhone5c
        case "iPhone6,1", "iPhone6,2":
            return .iPhone5s
        case "iPhone7,2":
            return .iPhone6
        case "iPhone7,1":
            return .iPhone6p
        case "iPhone8,1":
            return .iPhone6s
        case "iPhone8,2":
            return .iPhone6sp
        case "iPhone9,1", "iPhone9,3":
            return .iPhone7
        case "iPhone9,2", "iPhone9,4":
            return .iPhone7p
        case "iPhone8,4":
            return .iPhoneSE
        case "iPhone10,1", "iPhone10,4":
            return .iPhone8
        case "iPhone10,2", "iPhone10,5":
            return .iPhone8p
        case "iPhone10,3", "iPhone10,6":
            return .iPhoneX
        case "iPhone11,2":
            return .iPhoneXs
        case "iPhone11,4", "iPhone11,6":
            return .iPhoneXsMax
        case "iPhone11,8":
            return .iPhoneXR
        case "iPhone12,1":
            return .iPhone11
        case "iPhone12,3":
            return .iPhone11Pro
        case "iPhone12,5":
            return .iPhone11ProMax
        case "x86_64":
            return simulatorType()
        default:
            return .others
        }
    }()
    
    private class func simulatorType() -> DeviceType {
        let screenSize = (UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        switch screenSize {
        case (320.0, 568.0): // 5、5c、5s
            return .iPhone5
        case (375.0, 667.0): // 6、6s、7、7s、8、8s
            return .iPhone6
        case (414.0, 736.0): // plus系列
            return .iPhone8p
        case (375.0, 812.0): // x xs
            return .iPhoneX
        case (414.0, 896.0): // max XR
            return .iPhoneXsMax
        default:
            return .others
        }
    }
    class func isiPhoneXScreen() -> Bool {
        guard #available(iOS 11.0, *) else {
            return false
        }
        let isX = UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
        return isX
    }
    
    var appName:String{
        return (Bundle.main.infoDictionary?["CFBundleName"] as? String) ?? ""
    }
    
    var appVersion:String{
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    }
    
    var appBuild:String{
        return (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? ""
    }
    
//    var hasSafeArea: Bool {
//        return (isiPhoneX_Xs || isiPhoneXr_XsMax || isiPhoneX_Xs_11Pro_Kind || isiPhoneXr_XsMax_11_Kind || isiPhone12ProMax_Kind || isiPhone12_Pro_Kind || isiPhone12mini_Kind)
//    }
    
   
    
    /// 导航栏高度
    var navBarHeight: CGFloat {
        return hasSafeArea ? (88.0) : (64.0)
    }
    // 状态栏高度
    var statusHeight: CGFloat {
        return hasSafeArea ? (44.0) : (24.0)
    }
    // 底部不可控高度
    var bottomSafeHeight: CGFloat {
        return hasSafeArea ? (34.0) : (0.0)
    }
    // Tab高度
    var tabHeight: CGFloat{
        return hasSafeArea ? (83.0) : (49.0)
    }
    
    // 安全内容高度（无tab，无nav）
    var safeContentHeight: CGFloat{
        return UIScreen.main.bounds.size.height - UIDevice.current.bottomSafeHeight - UIDevice.current.statusHeight
    }
    
    var isIPhone5_Kind: Bool {
        return (UIScreen.main.bounds.size.width == 320 && UIScreen.main.bounds.size.height == 568) || (UIScreen.main.bounds.size.height == 320 && UIScreen.main.bounds.size.width == 568)
    }
    
    var isIPhone6_Kind: Bool {
        return [.iPhone6_8,.iPhone6_8p].contains(UIDevice.deviceType)
    }
    
    var isiPhoneX_Xs: Bool {
        return (UIScreen.main.bounds.size.width == 375 && UIScreen.main.bounds.size.height == 812) || (UIScreen.main.bounds.size.height == 375 && UIScreen.main.bounds.size.width == 812)
    }
    
    var isiPhoneXr_XsMax: Bool {
        return (UIScreen.main.bounds.size.width == 414 && UIScreen.main.bounds.size.height == 896) || (UIScreen.main.bounds.size.height == 414 && UIScreen.main.bounds.size.width == 896)
    }

    var isiPhoneX_Xs_11Pro_Kind: Bool {
        return (UIScreen.main.bounds.size.width == 375 && UIScreen.main.bounds.size.height == 812) || (UIScreen.main.bounds.size.height == 375 && UIScreen.main.bounds.size.width == 812)
    }

    var isiPhoneXr_XsMax_11_Kind: Bool {
        return (UIScreen.main.bounds.size.width == 414 && UIScreen.main.bounds.size.height == 896) || (UIScreen.main.bounds.size.height == 414 && UIScreen.main.bounds.size.width == 896)
    }

    var isiPhone12ProMax_Kind: Bool {
        return (UIScreen.main.bounds.size.width == 428 && UIScreen.main.bounds.size.height == 926) || (UIScreen.main.bounds.size.height == 428 && UIScreen.main.bounds.size.width == 926)
    }

    var isiPhone12_Pro_Kind: Bool {
        return (UIScreen.main.bounds.size.width == 390 && UIScreen.main.bounds.size.height == 844) || (UIScreen.main.bounds.size.height == 390 && UIScreen.main.bounds.size.width == 844)
    }

    var isiPhone12mini_Kind: Bool {
        return (UIScreen.main.bounds.size.width == 360 && UIScreen.main.bounds.size.height == 780) || (UIScreen.main.bounds.size.height == 360 && UIScreen.main.bounds.size.width == 780)
    }
}

struct DeviceType: OptionSet, Codable {
    let rawValue: Int
    
    /// 未合并类型
    static let iPhone5 = DeviceType(rawValue: 1 << 0)
    static let iPhone5c = DeviceType(rawValue: 1 << 1)
    static let iPhone5s = DeviceType(rawValue: 1 << 2)
    static let iPhoneSE = DeviceType(rawValue: 1 << 3)
    static let iPhone6 = DeviceType(rawValue: 1 << 4)
    static let iPhone6p = DeviceType(rawValue: 1 << 5)
    static let iPhone6s = DeviceType(rawValue: 1 << 6)
    static let iPhone6sp = DeviceType(rawValue: 1 << 7)
    static let iPhone7 = DeviceType(rawValue: 1 << 8)
    static let iPhone7p = DeviceType(rawValue: 1 << 9)
    static let iPhone8 = DeviceType(rawValue: 1 << 10)
    static let iPhone8p = DeviceType(rawValue: 1 << 11)
    static let iPhoneX = DeviceType(rawValue: 1 << 12)
    static let iPhoneXs = DeviceType(rawValue: 1 << 13)
    
    /// 合并后的类型
    static let iPhoneXsMax = DeviceType(rawValue: 1 << 14)
    static let iPhoneXR = DeviceType(rawValue: 1 << 15)
    static let iPhone11 = DeviceType(rawValue: 1 << 17)
    static let iPhone11Pro = DeviceType(rawValue: 1 << 18)
    static let iPhone11ProMax = DeviceType(rawValue: 1 << 19)
    static let others = DeviceType(rawValue: 1 << 16)
    static let iPhone5_SE: DeviceType = [iPhone5, iPhone5s, iPhone5c, iPhoneSE]
    static let iPhone6_8: DeviceType = [iPhone6, iPhone7, iPhone8]
    static let iPhone6_8p: DeviceType = [iPhone6p, iPhone7p, iPhone8p]
    static let iPhoneX_s: DeviceType = [iPhoneX, iPhoneXs]
    
    var isMatch: Bool {
        return contains(UIDevice.deviceType)
    }
}

extension UIDevice {
    var device:String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let platform = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
            return String(cString: ptr)
        }
        
        switch platform {
        case "iPhone5,1", "iPhone5,2":
            return "iPhone5"
        case "iPhone5,3", "iPhone5,4":
            return "iPhone5c"
        case "iPhone6,1", "iPhone6,2":
            return "iPhone5s"
        case "iPhone7,2":
            return "iPhone6"
        case "iPhone7,1":
            return "iPhone6p"
        case "iPhone8,1":
            return "iPhone6s"
        case "iPhone8,2":
            return "iPhone6sp"
        case "iPhone9,1", "iPhone9,3":
            return "iPhone7"
        case "iPhone9,2", "iPhone9,4":
            return "iPhone7p"
        case "iPhone8,4":
            return "iPhoneSE"
        case "iPhone10,1", "iPhone10,4":
            return "iPhone8"
        case "iPhone10,2", "iPhone10,5":
            return "iPhone8p"
        case "iPhone10,3", "iPhone10,6":
            return "iPhoneX"
        case "iPhone11,2":
            return "iPhoneXs"
        case "iPhone11,4", "iPhone11,6":
            return "iPhoneXsMax"
        case "iPhone11,8":
            return "iPhoneXR"
        case "x86_64","i386":
            return "iPhone Simulator"
        case  "iPhone12,1":
            return "iPhone 11"
        case "iPhone12,3":
            return "iPhone 11 Pro"
        case "iPhone12,5":
            return "iPhone 11 Pro Max"
        case "iPhone13,1":
            return "iPhone 12 mini"
        case "iPhone13,2":
            return "iPhone 12"
        case "iPhone13,3":
            return "iPhone 12 Pro"
        case "iPhone13,4":
            return "iPhone 12 Pro Max"
        default:
            return platform
        }
    }
    
    var UUIDString : String {
        let ad = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        return ad
    }
}


extension UIDevice {
    open override func setValue(_ value: Any?, forKey key: String) {
        
    }

    open override func value(forUndefinedKey key: String) -> Any? {
        return nil
    }
}
