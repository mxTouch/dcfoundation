//
//  DCFoundation
//

import Foundation

public func << <T>(lhs: inout Array<T>, rhs: T?) {
    lhs += rhs
}

public func << <T>(lhs: inout Array<T>, rhs: Array<T>?) {
    lhs += rhs
}

public func += <T>(lhs: inout Array<T>, rhs: T?)  {
    if let rhs = rhs {
        lhs.append(rhs)
    }
}

public func += <T>(lhs: inout Array<T>, rhs: Array<T>?)  {
    if let rhs = rhs {
        for item in rhs {
            lhs << item
        }
    }
}

public func -= <T>(lhs: inout Array<T>, rhs: T)  {
    if let rhs = (rhs as? NSObject) {
        var index: Int?
        var remove = true
        repeat {
            remove = false
            for (idx,item) in lhs.enumerated() {
                if let item = item as? NSObject {
                    if item == rhs {
                        remove = true
                        index = idx
                    }
                }
            }
            if remove {
                if let index = index {
                    lhs.remove(at: index)
                }
                index = nil
            }
        } while remove
    }
}

public func + <T>(lhs: Array<T>?, rhs: Array<T>?) -> Array<T>  {
    var list = Array<T>()
    if let lhs = lhs {
        for item in lhs {
            list << item
        }
    }
    if let rhs = rhs {
        for item in rhs {
            list << item
        }
    }
    return list
}

public protocol StringValue {
    var value: String { get }
}

public extension Array {
    
    public func makeArray<T>(_ range: NSRange? = nil, _ handler: (_ idx: Int, _ item: Element) -> T?) -> Array<T> {
        var list = [T]()
        var aRange = NSMakeRange(0, count)
        if let range = range {
            aRange = range
        }
        for i in aRange.location ..< aRange.location + aRange.length {
            if let value = handler(i, self[i]) {
                list << value
            }
        }
        return list
    }
    
}

public extension Array where Element : CustomStringConvertible {
    
    public func joinedBy(separator: String) -> String {
        var string = ""
        for (idx,item) in enumerated() {
            string += item.description
            if idx != count - 1 {
                string += separator
            }
        }
        if string.length > 0 {
            return string
        }
        return ""
    }
    
}

public extension Array {
    
    func subArray(range: NSRange) -> Array<Element> {
        var array = Array<Element>()
        for (idx,item) in self.enumerated() {
            if idx >= range.location && idx <= range.location + range.length {
                array << item
            }
        }
        return array
    }
    
    mutating func remove(predicate: (Array.Iterator.Element) throws -> Bool) {
        if let index = try? index(where: predicate) {
            if let index = index {
                self.remove(at: index)
            }
        }
    }
    
}

public func makeArray<T>(count: Int, handler: (_ idx: Int) -> T?) -> Array<T> {
    var list = [T]()
    for i in 0 ..< count {
        if let value = handler(i) {
            list << value
        }
    }
    return list
}

public extension Sequence where Element: Equatable {
    
    var uniqueElements: [Element] {
        return self.reduce(into: []) {
            uniqueElements, element in
            
            if !uniqueElements.contains(element) {
                uniqueElements.append(element)
            }
        }
    }
}
