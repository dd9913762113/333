//
//  String+Encryption.swift
//  3332323
//
//  Created by dd on 31/7/2021.
//

import Foundation
import CommonCrypto

// MARK: - Base64
extension String {
    
//    public func encodeToBase64() -> String {
//        return Data(self.utf8).base64EncodedString()
//    }
//
//    public func decodeFromBase64() -> String? {
//        guard let data = Data(base64Encoded: self) else {
//            return nil
//        }
//        return String(data: data, encoding: .utf8)
//    }
}


// MARK: - md5
extension String {
    
    public var md5: String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, self, CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate()
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        return hexString
    }
}

extension String {
    public var textInputIsVaild:Bool{
        var isVaild = true
        isVaild = !(self.isEmoji || self.isSpace) || self.isNineKeyborad
        return isVaild
    }
    
    public var truenameIsVaild:Bool{
        var isVaild = true
        isVaild = !self.isEmoji || self.isNineKeyborad
        return isVaild
    }
    
    public var isEmoji : Bool {
        let pattern = "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"
        let predicate = NSPredicate(format: "SELF MATCHES %@" ,pattern)
        return predicate.evaluate(with: self)
    }
    
    public var isSpace : Bool {
        return self == " "
    }
    
    public var isNineKeyborad : Bool {
        let nineSpace = ["➋","➌","➍","➎","➏","➐","➑","➒"]
        return nineSpace.contains(self)
    }
    
    /// 截取字符串
    /// - Parameters:
    ///   - start: 初始下标
    ///   - end: 结束下标
    func subString(start: Int, end: Int) -> String {
        if self.count < start { return self }
        if self.count < end { return self }
        if start > end { return self }
        let startInd = self.index(self.startIndex, offsetBy: start)
        let endInd = self.index(self.startIndex, offsetBy: end)
        return String(self[startInd..<endInd])
    }
}

// MARK: - 判断字符串只有字母和数字
extension String {
    func isCanInputOnlyNumAndCharacter() ->Bool {
        return self.isVaildNumAndCharacter() || self == .empty || self == "\n"
    }

    func isVaildNumAndCharacter() -> Bool {
        let reg = "^[a-zA-Z0-9]+$"
        let pre = NSPredicate(format: "SELF MATCHES %@", reg)
        if pre.evaluate(with: self) {
            return true
        }else{
            return false
        }
    }
}


extension String {
    
    func positionOf(sub:String, backwards:Bool = false)->Int {
        // 如果没有找到就返回-1
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
}

extension String {
    /// 将中文字符串转换为拼音
//    func transformToPinyin() -> String? {
//        return applyingTransform(.toLatin, reverse: false)?.applyingTransform(.stripCombiningMarks, reverse: false)
//    }
    
    /// 获取中文首字母
    func transformToPinyinHeader(_ needCompareWithAlphabet: Bool = false) -> String {
        let pinyin = transformToPinyin()
        let pinyinCompare = needCompareWithAlphabet ? pinyin?.uppercased() : pinyin?.capitalized
        var headPinyinStr = ""
        let _ = pinyinCompare.map { if $0 <= "Z" && $0 >= "A" { headPinyinStr.append($0) } }
        return headPinyinStr
    }
    /// 获取中文的第一个字母
    func transformToPinyinFirst(_ needCompareWithAlphabet: Bool = false) -> String {
        let pinyin = transformToPinyin()
        let pinyinCompare = needCompareWithAlphabet ? pinyin?.uppercased() : pinyin?.capitalized
        var headPinyinStr = ""
        let _ = pinyinCompare?.forEach {
            if headPinyinStr == "" {
                headPinyinStr.append($0)
            }
        }
        return headPinyinStr
    }
    
}

extension String{
    
//    func urlValue() -> URL? {
//        do {
//            return try self.asURL()
//        } catch {
//            return nil
//        }
//    }
    
    func match(min: Double, max: Double)  -> Bool {
        let value = Double(self.filter_ForCurrency()) ?? .zero
        return value >= min && value <= max
    }
    
    func match<S: StringProtocol>(min: S?, max: S?) -> Bool {
        guard let minS = min, let maxS = max else {
            return false
        }
        let min = Double(minS) ?? .zero
        let max = Double(maxS) ?? .zero

        return match(min: min, max: max)
    }
//    var intValue: Int {
//        return Int(self.filter_ForCurrency()) ?? .zero
//    }
//
//    var realVipLevel: String {
//        return "\(intValue == 0 ? intValue : intValue - 1)"
//    }
//
//    var floatValue: Float {
//        let temp = self.filter_isNotNumber().amountString
//        return Float(temp) ?? .zero
//    }
//
//    var doubleValue: Double {
//        let temp = self.filter_isNotNumber().amountString
//        return Double(temp) ?? .zero
//    }
    
    var amountString: String {
        //以防精度丢失问题
        var arr = description.components(separatedBy: ".")
        if arr.count < 2 {
            arr.append("00")
            return arr.joined(separator: ".")
        }
        var ex = "\(arr[1].prefix(2))"
        while ex.count < 2 {
            ex += "0"
        }
        arr[1] = ex
        return arr.joined(separator: ".")
    }
    
    
}


extension String{
    
    func filterString(_ filterStr: String, with replaceStr: String = "") -> String {
        return self.replacingOccurrences(of: filterStr, with: replaceStr)
    }
    
    /// 用于金额过滤‘,’ 暂时不使用numberFormatter
    func filter_isNotNumber() -> String {
        return replacingOccurrences(of: ",", with: "").replacingOccurrences(of: " ", with: "")
    }
    
    /// 用于金额过滤‘,’ 暂时不使用numberFormatter
    func filter_ForCurrency() -> String {
        return replacingOccurrences(of: ",", with: "")
    }
    
}

extension String {
    
    /// 截取字符串
    ///
    /// - Parameters:
    ///   - i: 开始位置
    ///   - length: 截取字符长度
    /// - Returns: 符合的字符串
    public func slicing(from i: Int, length: Int) -> String {
        guard length >= 0, i >= 0, i < count else { return "" }
        let startIndex = self.index(self.startIndex, offsetBy: i)
        guard i.advanced(by: length-1) <= count else {
            return String(self[startIndex...])
        }
        guard length > 0 else { return "" }
        let endIndex = index(startIndex, offsetBy: length-1)
        return String(self[startIndex...endIndex])
    }
    
    /// 判断是否为金额
    ///
    /// - Returns: true(是) or false(不是)
//    public func isValidMoney() -> Bool {
//        let isValidMoneyRegex = "^([1-9]\\d{0,20}|0)([.]?|(\\.\\d{1,2})?)$"
//        let money: NSPredicate = NSPredicate(format: "SELF MATCHES %@", isValidMoneyRegex)
//        return money.evaluate(with: self)
//    }
}

extension String {
//    
//    func AttributedNumberText(color: UIColor, defaultTextColor: UIColor = UIColor.black) -> NSMutableAttributedString {
//        let attText = NSMutableAttributedString(string: self)
//        let regx = try? NSRegularExpression.init(pattern: "[0-9.≈]", options: .caseInsensitive)
//        let rentPriceRanges = regx?.matches(in: self, options: .withTransparentBounds, range: NSRange(location: 0, length: self.count))
//        if rentPriceRanges?.count == 0 {
//            attText.setAttributes([NSAttributedString.Key.foregroundColor:defaultTextColor], range: NSMakeRange(0, self.count))
//        } else {
//            attText.setAttributes([NSAttributedString.Key.foregroundColor:defaultTextColor], range: NSMakeRange(0, self.count))
//            for range in rentPriceRanges! {
//                attText.setAttributes([NSAttributedString.Key.foregroundColor:color], range: NSMakeRange(range.range.location, range.range.length))
//            }
//        }
//        return attText
//    }
    
}

extension String {
    /// 判断邮箱地址是否合法
    ///
    /// - Returns: true(合法) or false(不合法)
    public func isValiteEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let email: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return email.evaluate(with: self)
    }
}

extension String {
    /// 获取四位随机数
    /// - Returns: 返回随机数的string类型
    static func getfourRandomString() -> String{
        let randomNumber:Int = Int(arc4random() % 9999)
        
        return String(format: "%0.4d", randomNumber)
    }
}

extension String {
    func getRangesofString(string:String) -> [NSRange]{
        let regex = try? NSRegularExpression(pattern: string, options: [])
        let results =  regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        var arrayRange = [NSRange]()
        if results?.count ?? 0 > 0{
            for result in results! {
                arrayRange.append(result.range)
            }
        }
        return arrayRange
    }
    
    
}

extension String {
//    var image:UIImage? {
//        return UIImage(named: self)
//    }
}

extension String {
//    func strPasswordMD5() ->String {
//        if ProjectConfig.APP_Plaform != .BOB_Plaform && ProjectConfig.APP_Plaform != .TB_Plaform {
//            return self.lowercased().md5()
//        }else {
//            return self
//        }
//
//    }
}


extension String {
//    var CGFloatValue: CGFloat {
//        return CGFloat(doubleValue)
//    }
//
//    var decimalNumberValue: Decimal{
//        let number = NSDecimalNumber(string: self)
//        return number.decimalValue
//    }
}

extension String {
   
    //替换第一个该字符串
    func replaceFirstOccupString(searchString:String,replacementString:String) -> String {
        
        if let range = self.range(of: searchString) {
            return self.replacingCharacters(in: range, with: replacementString)
        }
        return self
       
    }
    //替换最后一个该字符串
    func replaceLastString(searchString:String,replacementString:String) -> String{
        let options: String.CompareOptions
         options = [.backwards]
        if let range = self.range(of: searchString,
                                  options: options,
                                  range: nil,
                                  locale: nil) {
            return self.replacingCharacters(in: range, with: replacementString)
        }
        return self
    }
    
//    public func isPureChinese() -> Bool {
//        let phoneRegex = "^[\\u4e00-\\u9fa5]+$"
//        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
//        let phoneIsMatch = phonePred.evaluate(with: self)
//        return phoneIsMatch
//    }
    
    /// 便于链式判断是否包含特定string
    func containsCertain(_ string: String) -> String? {
        return self.contains(string) ? self : nil
    }
    
    //投注金额 10.3 - > 10 取整
    var betRoundMoney : Int{
        let strSeperoat = self.components(separatedBy: ".")
        return strSeperoat.first?.intValue ?? 0
    }
    
    var oddString : String{
        let oddStr = self
        var arr = oddStr.components(separatedBy: ".")
        if arr.count < 2 {
            arr.append("00")
            return arr.joined(separator: ".")
        }
        var ex = "\(arr[1].prefix(2))"
        while ex.count < 2 {
            ex += "0"
        }
        arr[1] = ex
        return arr.joined(separator: ".")
    }
    
    var oddLineString : String{
        let oddStr = self
        var arr = oddStr.components(separatedBy: ".")
        if arr.count < 2 {
            return self
        }
        if arr[1] == "0" || arr[1] == "00" {return arr[0]}
        if arr[1].last == "0" && arr[1].count > 1{
            arr[1] = arr[1].replacingOccurrences(of: "0", with: "")
        }
        return arr.joined(separator: ".")
    }
}

//转日期
extension String {
    
    func fullFormatDate() -> Date {
        let formm = DateFormatter()
        formm.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formm.timeZone = TimeZone(identifier: "Asia/Shanghai")
        let date = formm.date(from: self)
        return date ?? Date()
    }
    
}




extension  String {
//    func sizeWithAttributeString(attributedString: NSAttributedString, maxWidth: CGFloat) -> CGSize{
//        let rect = attributedString.boundingRect(with: CGSize(width:maxWidth, height:CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
//        return rect.size
//    }
//    func sizeWithFont(font: UIFont, maxWidth: CGFloat) -> CGSize {
//        let rect = NSString(string:self).boundingRect(with: CGSize(width: maxWidth, height: CGFloat(MAXFLOAT)), options: [NSStringDrawingOptions.usesFontLeading,NSStringDrawingOptions.truncatesLastVisibleLine,.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil)
//        return rect.size
//    }
//
//    func widthWithFont(fontSize: CGFloat, maxHeight: CGFloat = 15) -> CGFloat {
//        let font = UIFont.systemFont(ofSize: fontSize)
//        let rect = NSString(string:self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: maxHeight ), options: [NSStringDrawingOptions.usesFontLeading,NSStringDrawingOptions.truncatesLastVisibleLine,.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil)
//        return rect.size.width
//    }
//
//    func heightWith(font: UIFont, maxWidth: CGFloat) -> CGFloat {
//        let boundingRect = NSString(string: self).boundingRect(
//            with: CGSize(width: maxWidth, height: .greatestFiniteMagnitude),
//            options: .usesLineFragmentOrigin,
//            attributes: [.font: font],
//            context: nil)
//        return CGFloat(ceil(boundingRect.size.height))
//    }
//
//
//    func heightWithFont(width:CGFloat,fontSize: CGFloat) -> CGFloat {
//        if self.count == 0 {
//            return 0.0
//        }
//        let font = UIFont.systemFont(ofSize: fontSize)
//        let rect = NSString(string:self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT) ), options:  [.usesFontLeading,.truncatesLastVisibleLine,.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil)
//        return rect.size.height
//    }
//
//    func sizeWithFont(font: UIFont, maxWidth: CGFloat, lines: Int) -> CGSize {
//        var size = sizeWithFont(font: font, maxWidth: maxWidth)
//        let simple = "a你".size(withAttributes: [NSAttributedString.Key.font : font])
//        size.height = min(simple.height * CGFloat(lines), size.height)
//        return size
//    }
//    //富文本
//    /**
//     * attrStr   文本
//     * color     文本颜色
//     *
//     */
//    func AttributedText(attrStr: String? = nil, color: UIColor, defaultTextColor: UIColor = UIColor.black) -> NSMutableAttributedString {
//        let attText = NSMutableAttributedString(string: self)
//        let rentPriceRange = (self as NSString).range(of: self, options: NSString.CompareOptions())
//        if rentPriceRange.length == 0 {
//            attText.setAttributes([NSAttributedString.Key.foregroundColor:defaultTextColor], range: NSMakeRange(0, self.count))
//        } else {
//            attText.setAttributes([NSAttributedString.Key.foregroundColor:defaultTextColor], range: NSMakeRange(0, rentPriceRange.location))
//            attText.setAttributes([NSAttributedString.Key.foregroundColor:color], range: NSMakeRange(rentPriceRange.location, rentPriceRange.length))
//            attText.setAttributes([NSAttributedString.Key.foregroundColor:defaultTextColor], range: NSMakeRange(rentPriceRange.location + rentPriceRange.length, self.count - (rentPriceRange.location + rentPriceRange.length)))
//        }
//        return attText
//    }
//
//    func AttributedMutableText(attrStrs:[String],colors:[UIColor]) -> NSMutableAttributedString {
//        let attText = NSMutableAttributedString(string: self)
//        var i = 0
//        for attrStr in attrStrs {
//            let rentPriceRange = (self as NSString).range(of: attrStr, options: NSString.CompareOptions())
//            attText.addAttribute(NSAttributedString.Key.foregroundColor, value: colors[i], range: NSMakeRange(rentPriceRange.location, rentPriceRange.length))
//            i += 1
//        }
//        return attText
//    }
//    func AttributeText(attrStrs:[String],textSizes : [CGFloat]) -> NSAttributedString  {
//        let attText = NSMutableAttributedString(string: self)
//        var i = 0
//        for attrStr in attrStrs {
//            let rentPriceRange = (self as NSString).range(of: attrStr, options: NSString.CompareOptions())
//            attText.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: (textSizes[i])), range: NSMakeRange(rentPriceRange.location, rentPriceRange.length))
//            i += 1
//        }
//        return attText
//    }
//
//    // 设置行间距
//    func addAttributedStringWith(lineSpace:CGFloat,alignment : NSTextAlignment?,attr:NSAttributedString?) -> NSAttributedString {
//        let attributedString = attr == nil ? NSMutableAttributedString(string: self) : NSMutableAttributedString(attributedString: attr!)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = lineSpace-2 // 字体的行间距
////        paragraphStyle.firstLineHeadIndent = 20.0f;//首行缩进
////        paragraphStyle.paragraphSpacing = 15;//段与段之间的间距
////        paragraphStyle.minimumLineHeight = 10;//最低行高
////        paragraphStyle.maximumLineHeight = 20;//最大行高
//        paragraphStyle.alignment = alignment ?? .left
//        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, self.endIndex.utf16Offset(in: self)))
//        return attributedString
//    }
//    func AttributedStringWithImage(image:UIImage,size:CGSize) -> NSAttributedString{
//        let attch = NSTextAttachment()
//        attch.image = image
//        attch.bounds = CGRect(origin: CGPoint.zero, size: size)
//        return NSAttributedString(attachment: attch)
//    }

    //MARK: 判断1开头数字（手机号）
    func checkStingIsPhoneNum() -> Bool {
        let phoneRegex = "^1\\d{10}$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let phoneIsMatch = phonePred.evaluate(with: self)
        return phoneIsMatch
    }
    func filter_() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    /// 判空
    func checkStingIsEmpty() -> String? {
        return self.filter_().count > 0 ? self : nil
    }
    /// 判空
    func isEmpty() -> Bool {
        return self.filter_().count <= 0
    }
    //MARK: 判断6位数字（取款密码）
    func checkStingIsWPs() -> Bool {
        let phoneRegex = "^\\d{6}$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let phoneIsMatch = phonePred.evaluate(with: self)
        return phoneIsMatch
    }
    func checkStingIsEmail() -> Bool {
        let phoneRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let phoneIsMatch = phonePred.evaluate(with: self)
        return phoneIsMatch
    }
    //是否纯汉字
    func checkStingIsChinese() -> Bool {
        let phoneRegex = "^[\\u4e00-\\u9fa5]+$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let phoneIsMatch = phonePred.evaluate(with: self)
        return phoneIsMatch
    }
    //账户名 字母加数字组合
    func checkStingIsAccount() -> (result:Bool,msg:String) {
        if self == "" { return (false,"请输入用户名") }
        //if String(self[self.startIndex]).checkStringIsAllNum() { return (false,"用户名要以字母开头") }
        //if self.count < 4 { return (false,"用户名长度至少4位字符") }
        //if self.count > kMaxAccountLength { return (false,"用户名长度最长\(kMaxAccountLength)位字符") }
        let phoneRegex = "^[A-Za-z0-9]+$"
        //let phoneRegex = "(?!^[0-9]+$)(?!^[A-z]+$)(?!^[^A-z0-9]+$)^.{4,24}$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let phoneIsMatch = phonePred.evaluate(with: self)
        return (phoneIsMatch,"用户名只能包含数字和字母。")
        //return (phoneIsMatch,"用户名必须为4-24位，只能包含数字和字母。")
    }
    
    func isAccount() -> Bool {
        // MARK: 6-16位字母和数字组合
        let pwd =  "^[a-zA-Z][0-9A-Za-z]{5,16}$"
        let regextestpwd = NSPredicate(format: "SELF MATCHES %@",pwd)
        if (regextestpwd.evaluate(with: self) == true) {
            return true
        }else{
            return false
        }
    }
    
    func isPassword() -> Bool {
        // MARK: 6-16位字母和数字组合
        let pwd =  "[0-9A-Za-z]{6,16}$"
        let regextestpwd = NSPredicate(format: "SELF MATCHES %@",pwd)
        if (regextestpwd.evaluate(with: self) == true) {
            return true
        }else{
            return false
        }
    }
    
    /// 判断手机号码是否合法
    ///
    /// - Returns: true(合法) or false(不合法)
    public func isValiteMobile() -> Bool {
        let mobileRegex = "^1\\d{10}$"
        let mobile: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRegex)
        return mobile.evaluate(with: self)
    }
    
    /// 判断是否为数字
    ///
    /// - Returns: true(合法) or false(不合法)
    public func isValiteNumber() -> Bool {
        let numberRegex = "[0-9]"
        let number: NSPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        return number.evaluate(with: self)
    }
    
    // 6至12位  字母加数字组合
    func checkStingIsLoginPs() ->  (result:Bool,msg:String)  {
        if self == "" { return (false,"请输入密码") }
        //if self.count < 6 { return (false,"密码长度至少6位字符") }
        //if self.count > kMaxPasswordLength { return (false,"密码长度最长\(kMaxPasswordLength)位字符") }
        //let phoneRegex = "(?!^[0-9]+$)(?!^[A-z]+$)(?!^[^A-z0-9]+$)^.{6,12}$"
        let phoneRegex = "^[A-Za-z0-9]+$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let phoneIsMatch = phonePred.evaluate(with: self)
        return (phoneIsMatch,"密码只能包含字母和数字")
        //return (phoneIsMatch,"密码必须包含字母和数字")
    }
    // 6至12位  字母加数字组合
    func checkStingIsLogin() ->  Bool {
        if self == "" { return false }
        //if self.count < 6 { return (false,"密码长度至少6位字符") }
        //if self.count > kMaxPasswordLength { return (false,"密码长度最长\(kMaxPasswordLength)位字符") }
        //let phoneRegex = "(?!^[0-9]+$)(?!^[A-z]+$)(?!^[^A-z0-9]+$)^.{6,12}$"
        let phoneRegex = "^[A-Za-z0-9]+$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let phoneIsMatch = phonePred.evaluate(with: self)
        return phoneIsMatch
        //return (phoneIsMatch,"密码必须包含字母和数字")
    }
    // MARK: 判断数字
    func checkStringIsNum() -> Bool {
        let regex = "^[0-9]*$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        let isMatch = pred.evaluate(with: self)
        return isMatch
    }
    func checkStringIsAllNum() -> Bool {
        let regex = "[0-9]*"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        let isMatch = pred.evaluate(with: self)
        return isMatch
    }
    // 全字母
    func checkStringIsAllLetter() -> Bool {
        let regex = "[a-zA-Z]*"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        let isMatch = pred.evaluate(with: self)
        return isMatch
    }

    // 格式化 国际化数字 两位小数 例： 1，111.00
    func digitFormat() -> String {
        var number : NSNumber!
        if let double = Double(self) {
            number = NSNumber(value: double)
        } else if let float = Float(self) {
            number = NSNumber(value: float)
        } else {
           return self
        }
//        let format = NumberFormatter().then {
//            $0.numberStyle = .decimal
//            $0.maximumFractionDigits = 2
//        }
        let formatNum = NSString(format: "%.2f", number.doubleValue)
        return String(formatNum)
    }
    func addTowDigits() -> (str1:String,str2:String,result:String) {
        let arr = self.components(separatedBy: ".")
        if arr.count == 2 {
            return (arr[0],".\(arr[1])",self)
        } else {
            return (self,".00",self+".00")
        }
    }
    //使用正则表达式替换
    /**
     非中文：[^\\u4E00-\\u9FA5]
     非英文：[^A-Za-z]
     非数字：[^0-9]
     非中文或英文：[^A-Za-z\\u4E00-\\u9FA5]
     非英文或数字：[^A-Za-z0-9]
     非因为或数字或下划线：[^A-Za-z0-9_]*/
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
//    func confineChainese(textfield: UITextField) {
//        guard let _: UITextRange = textfield.markedTextRange else{
//            let cursorPostion = textfield.offset(from: textfield.endOfDocument,
//                                                 to: textfield.selectedTextRange!.end)
//            let pattern = "[^\\u4E00-\\u9FA5]"
//            var str = textfield.text?.pregReplace(pattern: pattern, with: "")
//            if str?.count ?? 0 > 32 {
//                str = String(str?.prefix(32) ?? "")
//            }
//            textfield.text = str
//            let targetPostion = textfield.position(from: textfield.endOfDocument,
//                                                   offset: cursorPostion)!
//            textfield.selectedTextRange = textfield.textRange(from: targetPostion,
//                                                              to: targetPostion)
//            return
//        }
//    }
    ///转换为日期格式
    func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    //隐藏真实姓名后半部分(保留第一个字)
    func hidenName()->String{
        if self.count <= 1 {
            return self
        }
        var rlt = self.mySubString(to: 1)
        for _ in 1 ..< self.count {
            rlt = rlt + "*"
        }
        return rlt
    }
    //隐藏真实邮箱
    func hidenEmail()->String{
        if !checkStingIsEmail() {
            return self
        }
        let arr_sp = self.components(separatedBy: "@")
        //保留前三个字符
        if arr_sp[0].count <= 3 {
            var tempStr = ""
            for _ in 0 ..< arr_sp[0].count {
                tempStr = tempStr + "*"
            }
            return tempStr + "@" + arr_sp[1]
        }
        var rlt = arr_sp[0].mySubString(to: 3)
        for _ in 3 ..< arr_sp[0].count {
            rlt = rlt + "*"
        }
        return rlt + "@" + arr_sp[1]
    }
    //隐藏真实手机号
    func hidenPhoneNum()->String{
        if !checkStingIsPhoneNum() {
            return self
        }
        return NSString(string: self).replacingCharacters(in: NSMakeRange(3,4), with: "****")
    }
    //隐藏银行卡号
    func hidenCardNum()->String{
        return NSString(string: NSString(string: self).replacingCharacters(in: NSMakeRange(7,4), with: " ****")).replacingCharacters(in: NSMakeRange(3,4), with: " ****")
    }
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }

    /// 截取字符串
    ///
    /// - Parameter index: 截取从index位开始之前的字符串
    /// - Returns: 返回一个新的字符串
    func mySubString(to index: Int) -> String {
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
    /// 截取字符串
    ///
    /// - Parameter index: 截取从index位开始到末尾的字符串
    /// - Returns: 返回一个新的字符串
    func mySubString(from index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
    
//    func rectString(string: String, size: CGSize) -> CGRect {
//
//        let font:UIFont! = UIFont(name: "EuphemiaUCAS",size: 15.0)
//        let attributes = [NSAttributedString.Key.font:font]
//        let option = NSStringDrawingOptions.usesLineFragmentOrigin
//        let rect:CGRect = string.boundingRect(with:size,options:option,attributes:attributes as [NSAttributedString.Key:Any],context:nil)
//        return rect
//    }

    // 格式化金额千位符字符串
//    func formattedNumber() -> String {
//        let numberFormatter = NumberFormatter()
//        numberFormatter.formatterBehavior = .behavior10_4
//        numberFormatter.numberStyle = .decimal
//        guard let numberString = numberFormatter.string(from: NSNumber(value: self.doubleValue)) else { return "0.00" }
//        return numberString;
//    }
}









