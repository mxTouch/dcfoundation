//
//  DCFoundation
//

import Foundation

extension Int {
    
    public var boolValue: Bool {
        return self > 0
    }
    
    func toString(radix: Int) -> String {
        assert(2...35 ~= radix, "radix must be between 2 and 35")
        if self == 0 { return "00" }
        
        let negative = self < 0
        var num = abs(self)
        var result = ""
        while num != 0 {
            let digit = num % radix
            if digit < 10 {
                result = "\(digit)\(result)"
            } else {
                result = String(Character(UnicodeScalar(digit + 55)!)) + result
            }
            num /= radix
        }
        
        let value = (negative ? "-" : "") + result
        return (value.length == 1) ? "0\(value)" : value
    }
    
    public func toHex() -> String {
        return self.toString(radix: 16)
    }
    
    public func toDouble() -> Double {
        return Double(self)
    }
    
}

extension Float  {
    
    public var boolValue: Bool {
        return self > 0
    }
    
}

extension Double  {
    
    public var boolValue: Bool {
        return self > 0
    }
    
}

public func + (lhs: Int, rhs: Float) -> Float {
    return (Float(lhs) + rhs)
}

