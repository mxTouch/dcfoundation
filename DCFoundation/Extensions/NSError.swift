//
//  DCFoundation
//

import Foundation

public extension NSError {
    
    convenience init?(localizedKey: String?, code aCode: Int? = nil, domain aDomain: String? = nil, userInfo:[String:Any]? = nil) {
        var code = aCode
        var domain = aDomain
        guard let text = localizedKey else {
            return nil
        }
        if domain == nil {
            if let identifier = (Bundle.main.infoDictionary?[kCFBundleIdentifierKey as String] as? String) {
                domain = identifier + ".error"
            } else {
                domain = "com.app.error"
            }
        }
        if code == nil {
            code = -1
        }
        self.init(domain: domain!, code: code!, userInfo: ([NSLocalizedDescriptionKey:text.localized]) + userInfo)
    }
    
}
