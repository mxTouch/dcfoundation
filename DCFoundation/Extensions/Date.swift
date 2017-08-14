//
//  NSDate.swift
//  MPFoundation
//
//  Created by Igor Danich on 08.01.16.
//  Copyright © 2016 Igor Danich. All rights reserved.
//

import Foundation

public extension Date {
    
    func string(format: String) -> String? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
    
}

public extension String {
    
    func date(format: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.date(from:self)
    }
    
}
