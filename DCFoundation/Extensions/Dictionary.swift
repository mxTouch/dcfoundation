//
//  Dictionary.swift
//  TX2
//
//  Created by Igor Danich on 29.01.16.
//  Copyright © 2016 dclife. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    var allKeys: [Key] {
        var keys = [Key]()
        for (key,_) in self {
            keys << key
        }
        return keys
    }
    
}

public func + <K,V>(lhs: Dictionary<K,V>?, rhs: Dictionary<K,V>?) -> Dictionary<K,V> {
    var info = Dictionary<K,V>()
    if let lhs = lhs {
        for (key,value) in lhs {
            info[key] = value
        }
    }
    if let rhs = rhs {
        for (key,value) in rhs {
            info[key] = value
        }
    }
    return info
}

public func << <K,V>(lhs: inout Dictionary<K,V>, rhs: Dictionary<K,V>?) {
    if let rhs = rhs {
        for (key,value) in rhs {
            lhs[key] = value
        }
    }
}

