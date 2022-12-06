//
//  String+Extension.swift
//  Games
//
//  Created by Jugg on 18/08/2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto

extension Character {

    /*
     value conversion
     */
    public var stringValue: String {
        return String(self)
    }
}

extension String {

    /*
     const
     */
    public static let empty: String = ""
    public static let space: String = " "

    /*
     value conversion
     */
    public var md5Value: String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, self, CC_LONG(lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate()
        return digest.reduce("") { $0 +  String(format:"%02x", $1) }
    }

    public var intValue: Int? {
        return Int(self)
    }

    public var floatValue: Float? {
        return Float(self)
    }

    public var CGFloatValue: CGFloat? {
        return floatValue.map { CGFloat($0) }
    }

    public var doubleValue: Double? {
        return Double(self)
    }

    public var urlValue: URL? {
        guard let url = URL(string: self) else { return nil }
        return url
    }

    public var utf8Value: String? {
        var arr = [UInt8]()
        arr += utf8
        return String(bytes: arr, encoding: .utf8)
    }

    public var dictValue: [String: Any]? {
        return self
            .data(using: .utf8)
            .flatMap { try? JSONSerialization.jsonObject(with: $0, options: .mutableContainers) as? [String: Any] }
    }

}


// MARK: - encode, decode
extension String {
    /// Base64
    public func encodeToBase64() -> String {
        return Data(utf8).base64EncodedString()
    }
    
    /// Base64
    public func decodeFromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    /// 将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    /// 将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}


// MARK: - manipulate funcs
extension String {
    
    /// 获取拼音首字母
    /// - Parameter isTrimmingCharacters: 是否转为字符串
    /// - Returns: 返回首字母
    func getFirstLetter(_ isTrimmingCharacters: Bool = false) -> String {
        // 注意,这里一定要转换成可变字符串
        let mutableString = NSMutableString.init(string: isTrimmingCharacters ? self.trimmingCharacters(in: CharacterSet.punctuationCharacters) : self)
        // 将中文转换成带声调的拼音
        CFStringTransform(mutableString as CFMutableString, nil, kCFStringTransformToLatin, false)
        // 去掉声调(用此方法大大提高遍历的速度)
        let pinyinString = mutableString.folding(options: String.CompareOptions.diacriticInsensitive, locale: NSLocale.current)
        // 将拼音首字母装换成大写
        let strPinYin = polyphoneStringHandle(nameString: self, pinyinString: pinyinString).uppercased()
        // 截取大写首字母
        let firstString = strPinYin.count == 0 ? "" : String(strPinYin[..<strPinYin.index(strPinYin.startIndex, offsetBy:1)])
        // 判断姓名首位是否为大写字母
        let regexA = "^[A-Z]$"
        let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        return predA.evaluate(with: firstString) ? firstString : "#"
    }
    
    
    /// 获取拼音
    /// - Parameter isTrimmingCharacters: 是否转为字符串
    /// - Returns: 拼音字母
    func getChinesePinyin(_ isTrimmingCharacters: Bool = false) -> String {
        // 注意,这里一定要转换成可变字符串
        let mutableString = NSMutableString.init(string: isTrimmingCharacters ? self.trimmingCharacters(in: CharacterSet.punctuationCharacters) : self)
        // 将中文转换成带声调的拼音
        CFStringTransform(mutableString as CFMutableString, nil, kCFStringTransformToLatin, false)
        // 去掉声调(用此方法大大提高遍历的速度)
        let pinyinString = mutableString.folding(options: String.CompareOptions.diacriticInsensitive, locale: NSLocale.current)
        return pinyinString.replacingOccurrences(of: " ", with: "")
    }
    
    /// 多音字处理
    func polyphoneStringHandle(nameString:String, pinyinString:String) -> String {
        if nameString.hasPrefix("长") {return "chang"}
        if nameString.hasPrefix("沈") {return "shen"}
        if nameString.hasPrefix("厦") {return "xia"}
        if nameString.hasPrefix("地") {return "di"}
        if nameString.hasPrefix("重") {return "chong"}
        
        return pinyinString;
    }

    // 滤空和换行
    public func filter(_ set: CharacterSet = .whitespacesAndNewlines) -> String {
        return components(separatedBy: set).joined(separator: .empty)
    }

    // 链式判断是否包含特定string
    public func isContains(_ string: String) -> String? {
        return contains(string) ? self : nil
    }

    // 链式判空
    public func isEmpty(_ isfilter: Bool = true) -> String? {
        if isfilter {
            return filter().count > 0 ? self : nil
        }
        return count > 0 ? self : nil
    }

    // 中文字符串转换为拼音
    public func transformToPinyin() -> String? {
        return self
            .applyingTransform(.toLatin, reverse: false)?
            .applyingTransform(.stripCombiningMarks, reverse: false)
    }

    // 中文字符串转换为拼音首字母
    public func transformToPinyinHeader() -> String? {
        let pinyin = transformToPinyin()
        let pinyinCompare = pinyin?.capitalized
        var headPinyinStr = ""
        let _ = pinyinCompare?.map { if $0 <= "Z" && $0 >= "A" { headPinyinStr.append($0) } }
        return headPinyinStr.filter().count > 0 ? headPinyinStr : nil
    }

    //判断是否合法账号
    public func isValidAccount() -> Bool {
        let regex = "^[a-zA-Z0-9]{6,16}$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }

    //判断是否是邀请码
    public func isValidInviteCode() -> Bool {
        let regex = "^[0-9]{6}$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }

    //判断是否是QQ
    public func isValidQQ() -> Bool {
        let regex = "^[1-9][0-9]{4,12}$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }

    // 链式判断密码是否合法
    public func isValidPassword() -> String? {
        return isValidPassword() ? self : nil
    }

    public func isValidPassword() -> Bool {
        let regex = "^[a-zA-Z0-9]{5,11}$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }

    // 链式判断手机号码是否合法
    public func isValidMobile() -> String? {
        return isValidMobile() ? self : nil
    }

    public func isValidMobile() -> Bool {
        let regex = "^1\\d{10}$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }

    // 链式判断邮箱地址是否合法
    public func isValidEmail() -> String? {
        return isValidEmail() ? self : nil
    }

    public func isValidEmail() -> Bool {
        let regex = "^([a-zA-Z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }

    // 链式判断真实姓名是否合法
    public func isValidRealName() -> String? {
        return isValidRealName() ? self : nil
    }

    public func isValidRealName() -> Bool {
        let regex = "^[\\u4e00-\\u9fa5]{2,5}$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }

    // 链式判断是否为金额
    public func isValidMoney() -> String? {
        return isValidMoney() ? self : nil
    }

    public func isValidMoney() -> Bool {
        let regex = "^([1-9]\\d{0,20}|0)([.]?|(\\.\\d{1,2})?)$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }

    // 链式判断是否是纯汉字
    public func isPureChinese() -> String? {
        return isPureChinese() ? self : nil
    }

    public func isPureChinese() -> Bool {
        let regex = "^[\\u4e00-\\u9fa5]+$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}

extension String {

    public enum regexType {
        case username, userpwd, realname, password, nickname, birthday, skype, onlynum, txpwd, email, url, verify, chinese, fanDian, telePhone, qqNumber
    }
    
    /// 正则表达式枚举
    ///
    /// - Parameters:
    ///   - regex: 需要用于判断的正则表达式
    ///   - return: 正则表达式字符串
    public func getRegexString(_ regex: regexType) -> String {
        switch regex {
        case .username:
            // 用户名
            return "^\\w{4,16}$"
        case .userpwd:
            // 用户密码    英文数字同时包含
    //                ^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$
            return "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$"
        case .realname:
            // 真实姓名
    //        return "^[\\u4e00-\\u9fa5a-zA-Z0-9-. _]{2,4}$"
            return "^[\\u4e00-\\u9fa5]{2,12}$"

        case .password:
            // 一般密码
            return "^\\w{8,16}$"
        case .nickname:
            // 用户昵称
            return "^[\\u4e00-\\u9fa5\\w]{0,25}$"
        case .birthday:
            // 用户生日(1940-2018)
            return "^(19([4-9][0-9])|20(1[0-8]|0[0-9]))-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$"
        case .skype:
            // 用户skype
            return "^[\\w-]{1}[\\w-\\@.]{0,49}$"
        case .txpwd:
            // 提现密码
            return "^\\d{6}$"
        case .email:
            // email
            return "^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$"
        case .url:
            // 网址
            return "^http|https://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$"
        case .verify:
            return "^\\w{4}$"
        case .chinese:
            //中文
            return "[\\u4e00-\\u9fa5]"
        case .fanDian:
            return "^[\\d]{1,2}(.\\d)?$"
        case .telePhone:
//            return "^1(3[0-9]|4[57]|5[0-9]|8[0-9]|7[0-9])\\d{8}$"
            return "^1\\d{10}$"
        case .qqNumber:
            return "^\\d{5,12}$"
        default:
            return ""
        }
    }
    
    /// String正则表达式匹配
    public func matches(_ regex: regexType) -> Bool {
        let regexString = getRegexString(regex)
        return self.range(of: regexString, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    /// String判断包含中文
    public func containsChinese() -> Bool {
        var chineseCount = 0
        for i in 0...self.count - 1 {
            let char: unichar = (self as NSString).character(at: i)
            if 0x4E00...0x9FA5 ~= char {
                chineseCount += 1
            }
        }
        return chineseCount > 0 ? true : false
    }
    
    /// String判断包含中文
    public func containsRegexChinese() -> Bool {
        for char in Array(self) {
            if String(char).matches(regexType.chinese) {
                return true
            }
        }
        return false
    }
    
    /// 时间格式
    public enum TimeFormat: String {
        case normal             = "yyyy-MM-dd HH:mm:ss"
        case yyMdHm             = "yy-MM-dd HH:mm"
        case yyyyMdHm           = "yyyy-MM-dd HH:mm"
        case yMd                = "yyyy-MM-dd"
        case MdHms              = "MM-dd HH:mm:ss"
        case MdHm               = "MM-dd HH:mm"
        case Hms                = "HH:mm:ss"
        case Hm                 = "HH:mm"
        case Md                 = "MM-dd"
        case yyMd               = "yy-MM-dd"
        case YYMMdd             = "yyyyMMdd"
        case yyyyMdHms          = "yyyyMMddHHmmss"
        case yyyyMdHmsS         = "yyyy-MM-dd HH:mm:ss.SSS"
        case yyyyMMddHHmmssSSS  = "yyyyMMddHHmmssSSS"
        case yMdWithSlash       = "yyyy/MM/dd"
        case yM                 = "yyyy-MM"
        case yMdChangeSeparator = "yyyy.MM.dd"
    }
    
    /// String时间戳转换为特定时间格式
    public func date(_ format: TimeFormat = .normal) -> String {
        if let timeInterval: TimeInterval = TimeInterval.init(self) {
            let date = Date(timeIntervalSince1970: timeInterval)
            let formatter = DateFormatter()
            formatter.dateFormat = format.rawValue
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
    
    /// 将时间戳转成指定的格式
    static func dateString(millisecond: TimeInterval,dateFormatter: String) -> String {
        return DateFormatter().then({$0.dateFormat = dateFormatter}).string(from: Date(timeIntervalSince1970: millisecond/1000))
    }
    
    // MARK: - String计算文字宽度
    /// String计算文字宽度
    public func getWidth(_ font: CGFloat, _ height: CGFloat = 20) -> CGFloat {
        let font = UIFont.systemFont(ofSize: font)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: .greatestFiniteMagnitude, height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    public func getWidth(_ font: UIFont, _ height: CGFloat = 20) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: .greatestFiniteMagnitude, height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    // MARK: - String计算文字高度
    /// String计算文字高度
    public func getHeight(_ font: CGFloat, _ width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: font)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    /// String计算文字高度
    public func getHeight(_ font: UIFont, _ width: CGFloat) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    /// String计算文字区域
    public func getRect(_ font: UIFont, _ width: CGFloat) -> CGRect {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect
    }
    
    /// 根据某年某月算当月天数
    public func userMonthCalculateDay(month: String) -> [String] {
        var month1 = month
        if let i = month1.firstIndex(of: "年") {
            month1.remove(at: i)
        }
        if let j = month1.firstIndex(of: "月") {
            month1.remove(at: j)
        }
        let format = DateFormatter.init()
        format.dateFormat = "yyyy-MM"
        let newDate = format.date(from: month1)
        var interval: Double = 0
        var firstDate: Date = Date()
        var lastDate: Date = Date()
        let calendar = NSCalendar.current
        if calendar.dateInterval(of: .month, start: &firstDate, interval: &interval, for: newDate ?? Date()) {
            lastDate = firstDate.addingTimeInterval(interval - 1)
        }
        let newformat = DateFormatter.init()
        newformat.dateFormat = "yyyy-MM-dd"
        let lastString = newformat.string(from: lastDate)
        let lastday = Int(String(lastString.split(separator: "-").last ?? "0"))!

        return (1...lastday).map({ (day)  in
            if day < 10 {
               return "0\(day)日"
            } else {
                return "\(day)日"
            }
        })
    }
}

extension NSMutableAttributedString {
    /// 富文本不同颜色strings组合
    public convenience init(colors: [UIColor], strings: [String], size: CGFloat) {
        self.init()
        var index = -1
        for color in colors {
            index = index + 1
            let attr = NSMutableAttributedString.init(string: strings[index])
            let firstAttributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: size), NSAttributedString.Key.foregroundColor:color]
            attr.setAttributes(firstAttributes, range: NSMakeRange(0, attr.length))
            append(attr)
        }
    }
    
    /// 富文本不同颜色不同字体strings组合
    public convenience init(colors:[UIColor], strings:[String], fonts:[UIFont]) {
        self.init()
        var index = -1
        for color in colors {
            index = index + 1
            let attr = NSMutableAttributedString.init(string: strings[index])
            let firstAttributes = [NSAttributedString.Key.font:fonts[index], NSAttributedString.Key.foregroundColor:color]
            attr.setAttributes(firstAttributes, range: NSMakeRange(0, attr.length))
            append(attr)
        }
    }
    
    /// 富文本不同颜色不同字体strings组合
    public convenience init(colors:[UIColor], strings:[String], fonts:[UIFont], lineSpacing:CGFloat, textAlign:NSTextAlignment) {
        self.init()
        var index = -1
        for color in colors {
            index = index + 1
            let attr = NSMutableAttributedString.init(string: strings[index])
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineSpacing = lineSpacing
            paragraph.alignment = textAlign
            let firstAttributes = [NSAttributedString.Key.font:fonts[index], NSAttributedString.Key.foregroundColor:color, NSAttributedString.Key.paragraphStyle: paragraph]
            attr.setAttributes(firstAttributes, range: NSMakeRange(0, attr.length))
            append(attr)
        }
    }
}

extension NSAttributedString {
    // MARK: - NSAttributedString计算文字高度
    /// NSAttributedString算高度
    public func getHeight(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height)
    }
    
    // MARK: - NSAttributedString计算文字宽度
    /// NSAttributedString算宽度
    public func getWidth(height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.width)
    }
}

extension String {
    /// 设置富文本，只有颜色
    func setContentColorAttributedString(params: Dictionary<String,UIColor>) -> NSMutableAttributedString {
        let attr = NSMutableAttributedString(string: self)
        params.forEach { (key,value) in
            let keyRange = (self as NSString).range(of: key)
            attr.addAttribute(.foregroundColor, value: value, range: keyRange)
        }
        return attr
    }
    /// 设置富文本
    func setContentAttributedString(params: Dictionary<String,Dictionary<NSAttributedString.Key, Any>>) -> NSMutableAttributedString {
        let attr = NSMutableAttributedString(string: self)
        params.forEach { (key,value) in
            let keyRange = (self as NSString).range(of: key)
            attr.addAttributes(value, range: keyRange)
        }
        return attr
    }
}


extension String {
    /// 去掉小数点后无意义的0
    func removeTrailingZero() -> String {
        if self.contains(".") {
            var tempString = self
            while tempString.hasSuffix("0") {
                tempString.removeLast()
            }
            if tempString.hasSuffix(".") {
                tempString.removeLast()
            }
            return tempString
        } else {
            return self
        }
    }
    
    /// 去掉小数点后无意义的0
    func removeLeadingStar() -> String {
        if self.hasPrefix("*") {
            var tempString = self
            while tempString.hasPrefix("*") {
                tempString.removeFirst()
            }
            return tempString
        } else {
            return self
        }
    }

}



extension String {
    // 时间戳转成字符串
    static func timeIntervalChangeToTimeStr(timeInterval: Double, _ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {
        let date:Date = Date.init(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter.init()
        if dateFormat == nil {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            formatter.dateFormat = dateFormat
        }
        return formatter.string(from: date as Date)
    }
    // 字符串转时间戳
    func timeStrChangeTotimeInterval(_ dateFormat: String? = "yyyy-MM-dd HH:mm:ss") -> String {
        if self.isEmpty {
            return ""
        }
        let format = DateFormatter.init()
        format.dateStyle = .medium
        format.timeStyle = .short
        if dateFormat == nil {
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            format.dateFormat = dateFormat
        }
        let date = format.date(from: self)
        return String(date!.timeIntervalSince1970)
    }
    
    // 字符串转时间戳
    func timeStrChangeTotimeInterval11(_ dateFormat: String? = "yyyy年MM月dd日") -> String {
        if self.isEmpty {
            return ""
        }
        let format = DateFormatter.init()
        format.dateStyle = .medium
        format.timeStyle = .short
        if dateFormat == nil {
            format.dateFormat = "yyyy年MM月dd日"
        }else{
            format.dateFormat = dateFormat
        }
        let date = format.date(from: self)
        return String(date!.timeIntervalSince1970*1000)
    }
}

