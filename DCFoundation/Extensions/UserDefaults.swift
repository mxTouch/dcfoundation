//
//  DCFoundation
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
