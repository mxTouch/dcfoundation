//
//  DCFoundation
//

import Foundation

public extension Date {
    
    func string(format: String) -> String? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
    
}

public extension Date {
    
    init(day: Int, month: Int, year: Int) {
        var comps = DateComponents()
        comps.day = day
        comps.year = year
        comps.month = month
        if let date = NSCalendar.current.date(from: comps) {
            self.init(timeIntervalSince1970: date.timeIntervalSince1970)
        } else {
            self.init()
        }
    }
    
    var month: Int {
        return NSCalendar.current.component(.month, from: self)
    }
    
    var year: Int {
        return NSCalendar.current.component(.year, from: self)
    }
    
    func string(style: DateFormatter.Style) -> String {
        let df = DateFormatter()
        df.dateStyle = style
        return df.string(from: self)
    }
    
}
