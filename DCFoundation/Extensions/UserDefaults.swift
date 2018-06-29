//
//  NSUserDefaults.swift
//  MPFoundation
//
//  Created by Igor Danich on 22.01.16.
//  Copyright © 2016 dclife. All rights reserved.
//

import Foundation

public func UserDefaults() -> Foundation.UserDefaults {
    return Foundation.UserDefaults.standard
}

public extension Foundation.UserDefaults {
    
    public subscript<T>(key: String) -> T? {
        get {
            return object(forKey: key) as? T
        }
        set {
            if let newValue = newValue {
                set(newValue, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
    
}
