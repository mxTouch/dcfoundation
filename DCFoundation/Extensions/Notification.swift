//
//  DCFoundation
//

import Foundation

class NotificationListener: NSObject {
    
    static let shared = NotificationListener()
    fileprivate var items = [Item]()
    
    func add(observer: AnyObject, name: String, object: AnyObject?, handler: @escaping ((_ : NSNotification) -> Void)) {
        items << Item(observer: observer, object: object, name: name, handler: handler)
        items.last?.subscribe()
        print("Notification add: \(name)")
    }
    
    func remove(observer: AnyObject, name: String?, object: AnyObject?) {
        print("Notification remove: \(name  ?? "")")
        var remove = [Item]()
        if let name = name {
            for item in items {
                guard item.observer === observer else {continue}
                guard item.name == name else {continue}
                if let object = object {
                    if item.object === object {
                        remove << item
                    }
                } else {
                    remove << item
                }
            }
        } else {
            for item in items {
                guard item.observer === observer else {continue}
                remove << item
            }
            NotificationCenter.default.removeObserver(observer)
        }
        for item in remove {
            item.unsubscribe()
            if let index = items.index(of: item) {
                items.remove(at: index)
            }
        }
    }
    
    class Item: NSObject {
        weak var observer: AnyObject!
        weak var object: AnyObject?
        var name: String!
        var handler: ((_ : NSNotification) -> Void)!
        
        init(observer: AnyObject, object: AnyObject?, name: String, handler: @escaping ((_ : NSNotification) -> Void)) {
            super.init()
            self.observer = observer
            self.object = object
            self.name = name
            self.handler = handler
        }
        
        func subscribe() {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(Item.onNotification(ntf:)),
                name: NSNotification.Name(rawValue: name),
                object: object
            )
        }
        
        func unsubscribe() {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: name), object: object)
        }
        
        @objc func onNotification(ntf: NSNotification) {
            print("Notification receive: \(ntf.name)")
            handler?(ntf)
        }
        
    }
    
}

public func NotificationAdd(observer: AnyObject, selector: Selector, name: String, object: AnyObject? = nil) {
    NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name), object: object)
}

public func NotificationAdd(observer: AnyObject, name: String, object: AnyObject? = nil, handler: @escaping ((_ notification : NSNotification) -> Void)) {
    NotificationListener.shared.add(observer: observer, name: name, object: object, handler: handler)
}

public func NotificationAdd(observer: AnyObject, name: NSNotification.Name, object: AnyObject? = nil, handler: @escaping ((_ notification : NSNotification) -> Void)) {
    NotificationListener.shared.add(observer: observer, name: name.rawValue, object: object, handler: handler)
}

public func NotificationRemove(observer: AnyObject, name: String? = nil, object: AnyObject? = nil) {
    NotificationListener.shared.remove(observer: observer, name: name, object: object)
}

public func NotificationRemove(observer: AnyObject, name: NSNotification.Name, object: AnyObject? = nil) {
    NotificationListener.shared.remove(observer: observer, name: name.rawValue, object: object)
}

public func NotificationPost(name: String, object: AnyObject? = nil, userInfo: [AnyHashable: Any]? = nil) {
    NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: object, userInfo: userInfo)
}

public func NotificationPost(name: NSNotification.Name, object: AnyObject? = nil, userInfo: [AnyHashable: Any]? = nil) {
    NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
}
