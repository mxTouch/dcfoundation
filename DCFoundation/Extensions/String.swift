//
//  String.swift
//  MPFoundation
//
//  Created by Igor on 08.12.15.
//  Copyright © 2015 dclife. All rights reserved.
//

import Foundation
import DCFoundationCommonCrypto

public extension String {
    
    public var localized: String {
        return LocalizedString(self)
    }
    
}

public extension String {

    public var length: Int {
        return count
    }
    
    public func appending(pathComponent: String) -> String {
        return (self as NSString).appendingPathComponent(pathComponent)
    }
    
    public func toDouble() -> Double {
        return (self as NSString).doubleValue
    }
    
    public func toInt() -> Int {
        return (self as NSString).integerValue
    }
    
    public func toHex() -> String {
        return toInt().toHex()
    }
    
}

public extension String {
    
    public var isValidEmail: Bool {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isValidToRegex("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
    }
    
    public var isValidPhoneNumber: Bool {
        let regex = "([\\+(]?(\\d){2,}[)]?[- \\.]?(\\d){2,}[- \\.]?(\\d){2,}[- \\.]?(\\d){2,}[- \\.]?(\\d){2,})|([\\+(]?(\\d){2,}[)]?[- \\.]?(\\d){2,}[- \\.]?(\\d){2,}[- \\.]?(\\d){2,})|([\\+(]?(\\d){2,}[)]?[- \\.]?(\\d){2,}[- \\.]?(\\d){2,})"
        return isValidToRegex(regex)
    }
    
    public func isValidToRegex(_ regex: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
}

public extension String {
    
    public func URLEncodedString() -> String {
        if let escapedString = addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            return escapedString
        }
        return ""
    }
    
    public func URLDecodedString() -> String {
        if let escapedString = removingPercentEncoding {
            return escapedString
        }
        return ""
    }
    
}

public extension String {
    
    public var MD5: String {
        let messageData = data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
    
}

