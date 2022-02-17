import Foundation

extension Collection {
    
    /**
     * Returns a random element of the Array or nil if the Array is empty.
     */
    public var sample : Element? {
        guard !isEmpty else { return nil }
        let offset = arc4random_uniform(numericCast(self.count))
        let idx = self.index(self.startIndex, offsetBy: numericCast(offset))
        return self[idx]
    }
    
    /**
     * Returns `count` random elements from the array.
     * If there are not enough elements in the Array, a smaller Array is returned.
     * Elements will not be returned twice except when there are duplicate elements in the original Array.
     */
    public func sample(_ count : UInt) -> [Element] {
        let sampleCount = Swift.min(numericCast(count), self.count)
        
        var elements = Array(self)
        var samples : [Element] = []
        
        while samples.count < sampleCount {
            if let idx = (0..<elements.count).sample {
                samples.append(elements.remove(at: idx))
            }
        }
        
        return samples
    }
    
}

extension Dictionary where Key == String, Value == Any {
    
    public var jsonString: String {
        do {
            let stringData = try JSONSerialization.data(withJSONObject: self as NSDictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
            if let string = String(data: stringData, encoding: String.Encoding.utf8){
                return string
            }
        } catch _ {
            
        }
        return ""
    }
    
    public var isValidJSONObject: Bool {
        do {
            let stringData = try JSONSerialization.data(withJSONObject: self as NSDictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
            if String(data: stringData, encoding: String.Encoding.utf8) != nil {
                return true
            }
        } catch _ {
            
        }
        return false
    }
    
    public func sortedJsonString(_ reverse: Bool = false) -> String {
        
        if (!isValidJSONObject) {
            SOUT("无法解析出JSONString")
            return ""
        }
        
        var namedPaird = [String]()
        
        let sortedKeysAndValues = reverse ? self.sorted(by: {$0.0 > $1.0}) : self.sorted(by: {$0.0 < $1.0})
        
        for (key, value) in sortedKeysAndValues {
            if value is [String: Any] {
                namedPaird.append("\"\(key)\":\((value as! [String:Any]).sortedJsonString(reverse))")
            } else if value is [Any] {
                namedPaird.append("\"\(key)\":\(value)")
            } else {
                namedPaird.append("\"\(key)\":\"\(value)\"")
            }
        }
        
        let returnString = namedPaird.joined(separator: ",")
        
        return "{\(returnString)}"
    }
    
    public func toData() -> Data? {
        let data = try? JSONSerialization.data(withJSONObject: self as NSDictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
        return data
    }
    
}
