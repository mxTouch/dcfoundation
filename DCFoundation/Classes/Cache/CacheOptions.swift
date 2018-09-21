//
//  DCFoundation
//

import Foundation

open class CacheOptions {
    
    open var storage    : CacheStorageProvider?
    open var converter  : CacheConverter?
    open var useMemory  : Bool
    
    public init(storage: CacheStorageProvider? = CacheDiskProvider(), converter: CacheConverter? = nil, useMemory: Bool = true) {
        self.converter = converter
        self.storage = storage
        self.useMemory = useMemory
    }
    
}
