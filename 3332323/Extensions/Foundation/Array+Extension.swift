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
