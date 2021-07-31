//
//  Math+Extension.swift
//  3332323
//
//  Created by dd on 31/7/2021.
//

import Foundation

import CoreGraphics
extension UInt64 {
    var stringValue: String {
        return String(self)
    }
}
extension Int64 {
    var stringValue: String {
        return String(self)
    }
}

extension Int {
    var half: Int {
        return self / 2
    }
    
    var double: Int {
        return self * 2
    }
    
    var stringValue: String {
        return String(self)
    }
}

extension Float {
    var half: Float {
        return self / 2.0
    }
    
    var double: Float {
        return self * 2.0
    }
    
    var stringValue: String {
        return String(self)
    }
}

extension CGFloat {
    var half: CGFloat {
        return self / 2.0
    }
    
    var double: CGFloat {
        return self * 2.0
    }
    
    var oddString : String{
        let oddStr = "\(self)"
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
        let oddStr = "\(self)"
        var arr = oddStr.components(separatedBy: ".")
        if arr.count < 2 {
            return oddStr
        }
        if arr[1] == "0" || arr[1] == "00" {return arr[0]}
        if arr[1].last == "0" && arr[1].count > 1{
            arr[1] = arr[1].replacingOccurrences(of: "0", with: "")
        }
        return arr.joined(separator: ".")
    }
}

extension Double {
    var half: Double {
        return self / 2.0
    }
    
    var double: Double {
        return self * 2.0
    }
    
    var stringValue: String {
        return String(self)
    }
}



extension Double {
    public func toMoneyString() -> String {
        return "\(self)".amountString
    }
}

extension Float {
    public func toMoneyString() -> String {
        return "\(self)".amountString
    }
}
