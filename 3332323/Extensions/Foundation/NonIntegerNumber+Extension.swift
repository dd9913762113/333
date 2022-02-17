import Foundation
import UIKit

extension Float {
    
    /*
     const
     */
    public static let zero: Float = 0.0
    
    /*
     mathematic
     */
    public var half: Float {
        return self / 2.0
    }
    
    public var double: Float {
        return self * 2.0
    }
    
    /*
     value  conversion
     */
    public var intValue: Int {
        return Int(self)
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
    
}


extension CGFloat {
    
    /*
     const
     */
    public static let zero: CGFloat = 0.0
    
    /*
     mathematic
     */
    public var half: CGFloat {
        return self / 2.0
    }
    
    public var double: CGFloat {
        return self * 2.0
    }
    
    /*
     value  conversion
     */
    public var intValue: Int {
        return Int(self)
    }
    
    public var floatValue: Float {
        return Float(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var stringValue: String {
        return String(Float(self))
    }
    
}


extension Double {
    
    /*
     const
     */
    public static let zero: Double = 0.0
    
    /*
     mathematic
     */
    public var half: Double {
        return self / 2.0
    }
    
    public var double: Double {
        return self * 2.0
    }
    
    /*
     value  conversion
     */
    public var intValue: Int {
        return Int(self)
    }
    
    public var floatValue: Float {
        return Float(self)
    }
    
    public var CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    public var stringValue: String {
        return String(self)
    }
    
}
