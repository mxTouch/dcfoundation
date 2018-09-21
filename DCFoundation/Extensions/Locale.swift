//
//  DCFoundation
//

import Foundation

public extension Locale {
    
    static func emojiFlag(country: String) -> String? {
        guard country.length == 2 else {return nil}
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in country.utf16 {
            usv.append(UnicodeScalar(base + Int(i))!)
        }
        return String(usv)
    }
    
}
