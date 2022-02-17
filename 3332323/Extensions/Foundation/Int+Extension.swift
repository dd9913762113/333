import Foundation
import UIKit

extension Int {
    
    /*
      const
     */
    public static let zero: Int = 0
    
    /*
      mathematic
     */
//    public var half: Int {
//        return self / 2
//    }
//
//    public var double: Int {
//        return self * 2
//    }
    
    /*
     value  conversion
     */
    public var floatValue: Float {
        return Float(self)
    }
    
    public var CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
//    public var stringValue: String {
//        return String(self)
//    }
    
    public var weekDayStr: String {
        switch self - 1 {
        case 1:
            return "星期一"
        case 2:
            return "星期二"
        case 3:
            return "星期三"
        case 4:
            return "星期四"
        case 5:
            return "星期五"
        case 6:
            return "星期六"
        case 0:
            return "星期日"
        default:
            return ""
        }
    }
}


extension UInt {
    
    /*
     const
     */
    public static let zero: UInt = 0
    
    /*
     mathematic
     */
    public var half: UInt {
        return self / 2
    }
    
    public var double: UInt {
        return self * 2
    }
    
    /*
     value  conversion
     */
    public var floatValue: Float {
        return Float(self)
    }
    
    public var CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var stringValue: String {
        return String(self)
    }
    
    public var intValue: Int {
        return Int(self)
    }
}


extension Int8 {
    
    /*
     const
     */
    public static let zero: Int8 = 0
    
    /*
     mathematic
     */
    public var half: Int8 {
        return self / 2
    }
    
    public var double: Int8 {
        return self * 2
    }
    
    /*
     value  conversion
     */
    public var floatValue: Float {
        return Float(self)
    }
    
    public var CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var stringValue: String {
        return String(self)
    }
    
    public var intValue: Int {
        return Int(self)
    }
}


extension UInt8 {
    
    /*
     const
     */
    public static let zero: UInt8 = 0
    
    /*
     mathematic
     */
    public var half: UInt8 {
        return self / 2
    }
    
    public var double: UInt8 {
        return self * 2
    }
    
    /*
     value  conversion
     */
    public var floatValue: Float {
        return Float(self)
    }
    
    public var CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var stringValue: String {
        return String(self)
    }
    
    public var intValue: Int {
        return Int(self)
    }
    
}


extension Int16 {
    
    /*
     const
     */
    public static let zero: Int16 = 0
    
    /*
     mathematic
     */
    public var half: Int16 {
        return self / 2
    }
    
    public var double: Int16 {
        return self * 2
    }
    
    /*
     value  conversion
     */
    public var floatValue: Float {
        return Float(self)
    }
    
    public var CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var stringValue: String {
        return String(self)
    }
    
    public var intValue: Int {
        return Int(self)
    }
    
}


extension UInt16 {
    
    /*
     const
     */
    public static let zero: UInt16 = 0
    
    /*
     mathematic
     */
    public var half: UInt16 {
        return self / 2
    }
    
    public var double: UInt16 {
        return self * 2
    }
    
    /*
     value  conversion
     */
    public var floatValue: Float {
        return Float(self)
    }
    
    public var CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var stringValue: String {
        return String(self)
    }
    
    public var intValue: Int {
        return Int(self)
    }
    
}


extension Int32 {
    
    /*
     const
     */
    public static let zero: Int32 = 0
    
    /*
     mathematic
     */
    public var half: Int32 {
        return self / 2
    }
    
    public var double: Int32 {
        return self * 2
    }
    
    /*
     value  conversion
     */
    public var floatValue: Float {
        return Float(self)
    }
    
    public var CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var stringValue: String {
        return String(self)
    }
    
    public var intValue: Int {
        return Int(self)
    }
    
}


extension UInt32 {
    
    /*
     const
     */
    public static let zero: UInt32 = 0
    
    /*
     mathematic
     */
    public var half: UInt32 {
        return self / 2
    }
    
    public var double: UInt32 {
        return self * 2
    }
    
    /*
     value  conversion
     */
    public var floatValue: Float {
        return Float(self)
    }
    
    public var CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var stringValue: String {
        return String(self)
    }
    
    public var intValue: Int {
        return Int(self)
    }
    
}


extension UInt64 {
    
    /*
     const
     */
    public static let zero: UInt64 = 0
    
    /*
     mathematic
     */
    public var half: UInt64 {
        return self / 2
    }
    
    public var double: UInt64 {
        return self * 2
    }
    
    /*
     value  conversion
     */
    public var floatValue: Float {
        return Float(self)
    }
    
    public var CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
//    public var stringValue: String {
//        return String(self)
//    }
    
    public var intValue: Int {
        return Int(self)
    }
    
}


extension Int64 {
    
    /*
     const
     */
    public static let zero: Int64 = 0
    
    /*
     mathematic
     */
    public var half: Int64 {
        return self / 2
    }
    
    public var double: Int64 {
        return self * 2
    }
    
    /*
     value  conversion
     */
    public var floatValue: Float {
        return Float(self)
    }
    
    public var CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
//    public var stringValue: String {
//        return String(self)
//    }
    
    public var intValue: Int {
        return Int(self)
    }
    
}
