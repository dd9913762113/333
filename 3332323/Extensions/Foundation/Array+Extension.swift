import Foundation

extension Array {
    public subscript (safe index: Int) -> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
}

extension NSArray {
    public subscript (safe index: Int) -> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
}

extension Array {
    
    /**
     * Shuffles the elements in the Array in-place using the
     * [Fisher-Yates shuffle](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle).
     */
    mutating func shuffle() {
        guard self.count >= 1 else { return }
        
        for i in (1..<self.count).reversed() {
            if let j = (0...i).sample {
                self.swapAt(j, i)
            }
        }
    }
    
    /**
     * Returns a new Array with the elements in random order.
     */
    var shuffled : [Element] {
        var elements = self
        elements.shuffle()
        return elements
    }
    
    /// 去重
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}

/*
 
 // 字符串去重
 let arr = ["apple", "strawberry", "pear", "apple", "orange", "orange", "strawberry"]
 let results = arr.enumerated().filter { (index,value) -> Bool in
     return arr.firstIndex(of: value) == index
 }.map {
     $0.element
 }
 print("removeDuplicate results = \(results)")
 
 // Model 去重
 let model1 = [BoxModel(id: 0, number: 0, com: "apple"),
              BoxModel(id: 1, number: 1, com: "strawberry"),
              BoxModel(id: 2, number: 2, com: "pear"),
              BoxModel(id: 3, number: 3, com: "apple"),
              BoxModel(id: 4, number: 4, com: "orange"),
             ]
 let arr1 = model1.filterRepeat { (item) -> String in
     return item.com
 }
 print("arr1 = \(arr1)")
 
 */

// 数组去重
extension Array {
    func filterRepeat<E: Equatable> (callback: (Element) -> E) -> [Element] {
        var temp = [Element]()
        for model in self {
            let identify = callback(model)
            if !temp.map({
                callback($0)
            }).contains(identify) {
                temp.append(model)
            }
        }
        
        return temp
    }
}
