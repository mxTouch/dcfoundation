//
//  DCFoundation
//

import Foundation

class DebugPinTimeInfo {
    
    var time    : TimeInterval
    var comment : String
    
    init(comment: String) {
        time = Date().timeIntervalSince1970
        self.comment = comment
    }
    
    func refresh(_ comment: String) {
        self.comment = comment
        time = Date().timeIntervalSince1970
    }
    
    func printTime(_ refresh: Bool) {
        print(comment, Date().timeIntervalSince1970 - time)
        if refresh {
            self.refresh(self.comment)
        }
    }
    
}

var DebugTimePinList = [String:DebugPinTimeInfo]()

public func DebugPinTime(_ label: String = "default", comment: String = "") {
    if let info = DebugTimePinList[label] {
        info.refresh(comment)
    } else {
        DebugTimePinList[label] = DebugPinTimeInfo(comment: comment)
    }
}

public func DebugPrintTime(_ label: String = "default", refresh: Bool = false) {
    if let info = DebugTimePinList[label] {
        info.printTime(refresh)
    }
}

public extension Array {
    
    func debugPrint() {
        print(self)
    }
    
}

public extension Dictionary {
    
    func debugPrint() {
        print(self)
    }
    
}
