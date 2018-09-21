//
//  DCFoundation
//

import Foundation

public let kNotificationLocalizationChanged = "kNotificationLocalizationChanged"

public func LocalizedString(_ key: String) -> String {
    return Localization.current.localizedString(key)
}

open class Localization {
    
    static var localizations = [Localization]()
    static var localization: Localization?
    
    static let currentKey = "LocalizationCurrentKey"
    
    public static var useEmptyKeys = true
    public static var showDefaultLanguageOnEmpty = true
    
    // MARK: - Static
    
    public static func availableLocalizations() -> [Localization] {
        preloadLocalizations()
        return localizations
    }
    
    public static func localizationWithIdentifier(_ identifier: String) -> Localization {
        for item in availableLocalizations() {
            if item.identifier == identifier {
                return item
            }
        }
        let localization = Localization(identifier: identifier)
        localizations << localization
        return localization
    }
    
    public static var defaultLocalization = Localization.localizationWithIdentifier("en")
    
    public static func setCurrent(localization newValue: Localization, notify aNotify: Bool = true) {
        var notify = aNotify
        if notify {
            notify = (localization != nil)
        }
        if localization == newValue {
            notify = false
        } else {
            localization = newValue
        }
        Foundation.UserDefaults.standard.setValue(newValue.identifier, forKey: currentKey)
        Foundation.UserDefaults.standard.synchronize()
        if notify {
            NotificationPost(name: kNotificationLocalizationChanged, object: nil, userInfo: nil)
        }
    }
    
    public static var current: Localization {
        set {
            setCurrent(localization: newValue)
        }
        get {
            preloadLocalizations()
            if localization == nil {
                if let identifier = (Foundation.UserDefaults.standard.value(forKey: currentKey) as? String) {
                    localization = localizationWithIdentifier(identifier)
                } else if localizations.count == 1 {
                    localization = localizations.first!
                } else {
                    localization = defaultLocalization
                }
            }
            
            return localization!
        }
    }
    
    static func preloadLocalizations() {
        if localizations.count > 0 {
            return
        }
        for identifier in Locale.availableIdentifiers {
            let pathFormat = "%@/%@.lproj"
            let name = identifier.replacingOccurrences(of: "_", with: "-")
            if let bundle = Bundle(path: String(format: pathFormat, arguments: [Bundle.main.bundlePath, name])) {
                let localization = Localization(identifier: identifier)
                if let path = bundle.path(forResource: "Localizable", ofType: "strings") {
                    localization.addLocalizationStrings(path)
                }
                localizations << localization
            }
        }
        if localizations.count == 0 {
            let localization = Localization(identifier: "en_US")
            if let path = Bundle.main.path(forResource: "Localizable", ofType: "strings") {
                localization.addLocalizationStrings(path)
            } else {
                let comps = NSHomeDirectory().components(separatedBy: "/")
                if comps.count > 2 {
                    let home = "/" + comps[1] + "/" + comps[2]
                    let path = home.appending(pathComponent: "Library/Application Support/Xcode/XIBLocalizations.strings")
                    if FileExistsAt(path: path) {
                        localization.addLocalizationStrings(path)
                    }
                }
            }
            localizations << localization
        }
    }
    
    // MARK: - Properties
    
    open fileprivate(set) var locale: Locale?
    open fileprivate(set) var identifier: String!
    
    open var name: String {
        if let name = (locale as NSLocale?)?.displayName(forKey: NSLocale.Key.identifier, value: identifier) {
            if name.length > 0 {
                return (name as NSString).substring(to: 1).uppercased() + (name as NSString).substring(from: 1)
            }
            return name
        }
        return ""
    }
    
    open var localizedName: String {
        if let name = (Localization.localization?.locale as NSLocale?)?.displayName(forKey: NSLocale.Key.identifier, value: identifier) {
            return name
        }
        return ""
    }
    
    open var allKeys: [String] {
        return [String]()
    }
    
    var strings = [String:String]()

    // MARK: - Init
    
    init() {
    }
    
    init(identifier: String) {
        self.locale = Locale(identifier: identifier)
        self.identifier = identifier
    }
    
    // MARK: - Methods
    
    open func localizedString(_ key: String) -> String {
        if let value = strings[key] {
            if value.length == 0 {
                if Localization.useEmptyKeys {
                    return value
                }
            } else {
                return value
            }
        }
        if Localization.showDefaultLanguageOnEmpty {
            if let value = Localization.defaultLocalization.strings[key] {
                return value
            }
        }
        return key
    }
    
    open func addLocalizationStrings(_ path: String, replace: Bool = true) {
        if let strings = (NSDictionary(contentsOfFile: path) as? [String:String]) {
            addLocalizationStrings(strings, replace: replace)
        }
    }
    
    open func addLocalizationStrings(_ strings: [String:String], replace: Bool = true) {
        for (key,aValue) in strings {
            let value = aValue.replacingOccurrences(of: "%s", with: "%@")
            if replace {
                self.strings[key] = value
            } else if strings[key] == nil {
                self.strings[key] = value
            }
        }
    }
    
}

public func == (left: Localization?, right: Localization?) -> Bool {
    return left?.identifier == right?.identifier
}

public func == (left: Localization?, right: String?) -> Bool {
    return left?.identifier == right
}
