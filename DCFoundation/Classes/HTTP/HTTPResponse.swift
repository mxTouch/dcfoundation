//
//  HTTPResponse.swift
//
//  Created by Igor Danich on 9/6/17.
//  Copyright © 2017 dclife. All rights reserved.
//

import Foundation

public class HTTPResponse: NSObject {

    fileprivate let response    : HTTPURLResponse?
    
    public let responseError   : Error?
    public let data            : Data?
    
    public var url             : URL? {
        return response?.url
    }
    
    public var statusCode      : Int {
        return response?.statusCode ?? 0
    }
    
    public var headers         : [String:String] {
        return response?.allHeaderFields as? [String:String] ?? [:]
    }
    
    required public init(response: HTTPURLResponse?, data: Data?, error: Error?) {
        self.response = response
        self.data = data
        self.responseError = error
        super.init()
    }
    
    public func logPrint() {
        print("----------------Response---------------")
        print("\(url?.absoluteString ?? "")")
        print(headers)
        if let data = data {
            if let string = String(data: data, encoding: .utf8) {
                print(string)
            }
        }
        print("---------------------------------------")
    }
    
}
