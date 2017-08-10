//
//  NSDate.swift
//  MPFoundation
//
//  Created by Igor Danich on 08.01.16.
//  Copyright © 2016 Igor Danich. All rights reserved.
//

import Foundation

public extension Date {
    
//    public init(string: String, format: String) {
//        let df = DateFormatter()
//        df.dateFormat = format
//        if let date = df.date(from: string) {
//            (self as NSDate).(timeIntervalSince1970: date.timeIntervalSince1970)
//        } else {
//            (self as NSDate).init(timeIntervalSince1970: Date().timeIntervalSince1970)
//        }
//    }
    
    public func string(format: String) -> String? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
    
}
