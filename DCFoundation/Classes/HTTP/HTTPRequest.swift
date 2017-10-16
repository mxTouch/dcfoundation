//
//  Request.swift
//
//  Created by Igor Danich on 9/6/17.
//  Copyright © 2017 dclife. All rights reserved.
//

import Foundation

open class HTTPRequest: NSObject {
    
    public enum ContentType: String {
        case formURLEncoded     = "application/x-www-form-urlencoded"
        case multipartFormData  = "multipart/form-data"
        case json               = "application/json"
        case custom             = "custom"
    }
    
    public enum Method: String {
        case post   = "POST"
        case get    = "GET"
        case put    = "PUT"
        case delete = "DELETE"
    }
    
    let id = NSUUID().uuidString
    
    public let url          : URL
    public var headers      : [String:String]
    public var method       : Method
    public var body         : Any?
    public var query        = [String:Any]()
    public var contentType  = ContentType.custom
    
    fileprivate var queryString: String {
        var items = [String]()
        for (key,value) in query {
            let eKey = "\(value)".URLEncodedString()
            items << "\(key.URLEncodedString())=\(eKey)"
        }
        return items.joinedBy(separator: "&")
    }
    
    var urlRequest: URLRequest {
        var url = self.url
        if queryString.length > 0 {
            url = URL(string: self.url.absoluteString + "?" + queryString)!
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        for (key,value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        if contentType != .custom {
            request.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        }
        if let body = body as? Data {
            request.httpBody = body
        } else if let values = body as? [String:Any] {
            switch contentType {
            case .json:
                request.httpBody = try? JSONSerialization.data(withJSONObject: values, options: .prettyPrinted)
            case .multipartFormData:
                let multipart = MultipartBuilder(values: values)
                request.addValue(contentType.rawValue + ";boundary=\(multipart.boundary)", forHTTPHeaderField: "Content-Type")
                request.httpBody = multipart.buildData()
                break
            default: break
            }
        } else if let items = body as? [MultipartItem] {
            let multipart = MultipartBuilder(items: items)
            request.addValue(contentType.rawValue + ";boundary=\(multipart.boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = multipart.buildData()
        }
        return request
    }
    
    public init(url: URL, method: Method = .get) {
        self.url = url
        self.method = method
        headers = [:]
        super.init()
    }
    
    public init(request: HTTPRequest) {
        url = request.url
        method = request.method
        query = request.query
        body = request.body
        headers = request.headers
        super.init()
    }
    
    public func logPrint() {
        print("----------------Request----------------")
        print("\(method.rawValue) \(url.absoluteString)?\(queryString)")
        print(headers)
        if let body = body as? Data {
            if let string = String(data: body, encoding: .utf8) {
                print(string)
            }
        } else if let body = body as? [String:Any] {
            print(body)
        }
        print("---------------------------------------")
    }
    
}
