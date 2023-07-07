//
//  SwiftDate.swift
//  3332323
//
//  Created by dd on 7/7/2023.
//  Copyright © 2023 XJW. All rights reserved.
//

enum RequestTimeType {
     /// yyyy-MM-dd HH:mm:ss
     case TimeNormal
     /// yyyy-MM-dd HH:mm:ss.SSS
     case TimeMSNormal
     /// 时间戳
     case TimeStamp
     /// yyyy-MM-dd
     case TimeYYYYMMdd
     /// yyyy-MM-dd HH:mm:ss ZZZZ
     case TimeAndTimeZone
 }



import Foundation

class DK_SwiftDateVC: SportBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let string = "2023-07-07 11:27:44"

        requestTimeStampAndTimeZone()
        timeStampParsing(time: string, timeType: .TimeNormal)
        timeStringToInterval(time: string, timeType: .TimeNormal)
        
        DLog("2023-07-07 11:27:44 转换 \(string.toLocalTime)")
    }

    
    
    // MARK:获取时间戳和时区
         func requestTimeStampAndTimeZone() -> (Int,String) {
            let timeStamp = Date().timeIntervalSince1970 // 获取时间戳
            let systemTimezone = NSTimeZone.system
            let tempTZ = systemTimezone.abbreviation()!
            DLog("****时间戳:\(Int(timeStamp))\n****时区:\(tempTZ)")
            DLog("GMT:\(systemTimezone.secondsFromGMT(for: Date()))\noffset:\(systemTimezone.daylightSavingTimeOffset())")
            DLog("原始时间:\(Date())")
            // 过滤掉GMT
            let timeZone = tempTZ.replacingOccurrences(of: "GMT", with: "")
            return (Int(timeStamp),timeZone)
        }
    
    
    /// 时间戳解析（时间戳加时区转换成时间戳后转成相关类型的时间）----return String（传入的数据不符合标准将返回空）
        /// - Parameters:
        ///   - time: 时间戳加时区
        ///   - timeType: 需要转成的时间类型
         func timeStampParsing(time : String,timeType : RequestTimeType) -> String {
            var timeStamp : TimeInterval = 0
            // 判断给的字符串是否大于10位数
            if time.count >= 10 {
                // 截取前10个字符
                let tempTimeStamp = time.prefix(10)
                // 判断截取后的字符串是否是数字
//                if GlobalTools.authNumber(content: String(tempTimeStamp)) {
//                    timeStamp = TimeInterval(tempTimeStamp)!
//                } else {
//                    return ""
//                }
                timeStamp = TimeInterval(Int(tempTimeStamp) ?? 1234)
            } else {
                return ""
            }
            let date = Date(timeIntervalSince1970: timeStamp)
            let dateFormatter = DateFormatter()
            switch timeType {
            case .TimeMSNormal:
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
            case .TimeStamp:
                return "\(timeStamp)"
            case .TimeNormal:
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            case .TimeYYYYMMdd:
                dateFormatter.dateFormat = "yyyy-MM-dd"
            case .TimeAndTimeZone:
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
            }
            let time = dateFormatter.string(from: date)
            DLog("Time---->\(time)")
            return time
        }
    
    /// 时间年月日等转时间戳
        /// - Parameters:
        ///   - time: 需要转的时间
        ///   - timeType: 时间类型
         func timeStringToInterval(time : String,timeType : RequestTimeType) -> TimeInterval {
            let dateFormatter = DateFormatter()
            switch timeType {
            case .TimeMSNormal:
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
            case .TimeStamp:
                return 0
            case .TimeNormal:
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            case .TimeYYYYMMdd:
                dateFormatter.dateFormat = "yyyy-MM-dd"
            case .TimeAndTimeZone:
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
            }
            let date = dateFormatter.date(from: time)
            let timeStamp = date?.timeIntervalSince1970
            DLog("Date--->\(date!)************TimeStamp--->\(timeStamp!)")
            return timeStamp!
        }
}

// GMT+0 转成手机默认时间
extension String {
    var toLocalTime: String {
        if self.isEmpty {
            return ""
        }
        let format = DateFormatter.init()
        format.timeZone = .init(abbreviation: "GMT+0")
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = format.date(from: self)
        let ddd = date!.timeIntervalSince1970
        DLog("ddd = \(ddd)")
        let date2:Date = Date.init(timeIntervalSince1970: ddd)
        let tempTZ = NSTimeZone.system.abbreviation()!
        format.timeZone = .init(abbreviation: tempTZ)
        let strings2 = format.string(from: date2 as Date)
        DLog("strings2 = \(strings2)")
        return strings2
    }
    
    var lc: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// h5 多语言环境参数
    var lcURL: String {
        if self.contains("lang=") {
            return self
        }
        return self
//        if self.contains("?") {
//            return self + "&lang=\(LanguageManager.shared.dbjLanguageMatchType())"
//        }
//
//        return self + "?lang=\(LanguageManager.shared.dbjLanguageMatchType())"
    }
    
    /// 图片字符串多语言
    var lcImage: String {
//        switch LanguageManager.shared.currentLanguage {
//        case .CMN: return self
//        case .VIE: return self.appending("_vi")
//        default: return self
//        }
        return self
    }
}
