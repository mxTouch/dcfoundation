//
//  NSData.swift
//  MPFoundation
//
//  Created by Igor Danich on 19.01.16.
//  Copyright © 2016 Mediapark. All rights reserved.
//

import Foundation

public extension Data {
    
    var SHA1: String {
        return MPFoundationMakeDataSHA1(self)
    }
    
    var pushToken: String? {
        return (self as NSData).description.replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "<", with: "")
            .replacingOccurrences(of: ">", with: "")
    }
    
}
