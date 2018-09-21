//
//  DCFoundation
//

import Foundation

public func SendDeepLink(_ link: DeepLink?) {
    guard let link = link else {return}
    for item in DeepLinkActionHandlers {
        item.handleLink(link)
    }
}

public func SendDeepLink(_ path: String, info: [String:Any]? = nil) {
    SendDeepLink(DeepLink(path: path, info: info))
}

var DeepLinkActionHandlers = [DeepLinkActionHandler]()

class DeepLinkActionHandler {
    weak var object: AnyObject?
    var handler: ((DeepLink) -> Void)?
    var path: String?
    
    init(object: Any?, path: String?, handler: ((DeepLink) -> Void)?) {
        self.object = object as AnyObject?
        self.path = path
        self.handler = handler
    }
    
    func handleLink(_ link: DeepLink) {
        if let path = path {
            if link.path.hasPrefix(path) {
                handler?(link)
            }
        } else {
            handler?(link)
        }
    }
    
}

public func DeepLinkAddHandler(_ object: Any?, path: String? = nil, handler: ((DeepLink) -> Void)?) {
    DeepLinkActionHandlers << DeepLinkActionHandler(object: object, path: path, handler: handler)
}

public func DeepLinkRemoveHandler(_ object: Any?, path: String? = nil) {
    var remove = [DeepLinkActionHandler]()
    for item in DeepLinkActionHandlers {
        if item.object == nil {
            remove << item
            continue
        }
        if let path = path {
            if item.path == path {
                remove << item
            }
        } else {
            remove << item
        }
    }
    for item in remove {
        DeepLinkActionHandlers -= item
    }
}

open class DeepLink {
    
    open fileprivate(set) var path: String
    open fileprivate(set) var info: [String:Any]?
    open var name: String {
        guard let name = path.components(separatedBy: "/").first else {
            return ""
        }
        return name
    }
    
    open var next: DeepLink? {
        var comps = path.components(separatedBy: "/")
        if comps.count > 1 {
            comps.removeFirst()
            let path = (comps as NSArray).componentsJoined(by: "/")
            if path.length == 0 {return nil}
            return DeepLink(path: path, info: info)
        }
        return nil
    }

    public init(path: String, info: [String:Any]? = nil) {
        self.path = path
        self.info = info
    }
    
    public init?(url: URL) {
        guard let host = url.host else {
            self.path = ""
            return nil
        }
        self.path = host + url.path
        if let params = url.queryParameters {
            var info = [String:Any]()
            for (key,value) in params {
                info[key] = value
            }
            self.info = info
        }
    }
    
}

public protocol DeepLinkAction {
    func handleDeepLink(_ link: DeepLink) -> Bool
}
