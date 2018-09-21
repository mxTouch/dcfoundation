//
//  DCFoundation
//

import Foundation
import ObjectiveC

final class Lifted<T>: NSObject {
    let value: T?
    init(_ x: T?) {
        value = x
    }
}

public func RuntimeSetAssociatedObject<T>(_ object: Any, value: T?, key: UnsafeRawPointer) {
    if let v: NSObject = value as? NSObject {
        objc_setAssociatedObject(object, key, v, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    } else {
        objc_setAssociatedObject(object, key, Lifted<T>(value), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

public func RuntimeGetAssociatedObject<T>(_ object: Any, key: UnsafeRawPointer) -> T? {
    if let v = objc_getAssociatedObject(object, key) as? T {
        return v
    } else if let v = objc_getAssociatedObject(object, key) as? Lifted<T> {
        return v.value
    } else {
        return nil
    }
}
