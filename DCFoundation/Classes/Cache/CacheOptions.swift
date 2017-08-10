//
//  CacheOptions.swift
//  RocketBall
//
//  Created by Igor Danich on 05.02.16.
//  Copyright © 2016 Igor Danich. All rights reserved.
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
