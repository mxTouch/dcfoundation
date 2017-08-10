//
//  CollectionType.swift
//  MPLibrary
//
//  Created by Igor Danich on 21.08.16.
//  Copyright © 2016 dclife. All rights reserved.
//

import Foundation

public extension Collection where Index : Comparable, Index : Comparable {
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
