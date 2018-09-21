//
//  DCFoundation
//

import Foundation

public extension Collection where Index : Comparable, Index : Comparable {
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
