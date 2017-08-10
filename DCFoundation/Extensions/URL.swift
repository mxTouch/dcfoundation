//
//  NSURL.swift
//  TX2
//
//  Created by Igor Danich on 11.02.16.
//  Copyright © 2016 dclife. All rights reserved.
//

import Foundation

public extension URL {
    
    var queryParameters: [String:String]? {
        if let list = query?.components(separatedBy: "&") {
            var params = [String:String]()
            for item in list {
                let comps = item.components(separatedBy: "=")
                guard let key = comps.first?.URLDecodedString() else {
                    continue
                }
                guard let value = comps.last?.URLDecodedString() else {
                    continue
                }
                params[key] = value
            }
            return params.count > 0 ? params : nil
        }
        return nil
    }
    
}
