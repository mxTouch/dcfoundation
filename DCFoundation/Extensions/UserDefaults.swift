//
//  NSUserDefaults.swift
//  MPFoundation
//
//  Created by Igor Danich on 22.01.16.
//  Copyright © 2016 Mediapark. All rights reserved.
//

import Foundation

public func UserDefaults() -> Foundation.UserDefaults {
    return Foundation.UserDefaults.standard
}

public extension Foundation.UserDefaults {
    
    public subscript(key: String) -> Any? {
        get {
            return object(forKey: key)
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
