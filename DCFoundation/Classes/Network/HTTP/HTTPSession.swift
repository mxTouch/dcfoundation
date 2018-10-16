//
//  DCFoundation
//

import Foundation

open class HTTPSession: NSObject, URLSessionDelegate {

    public static let shared = HTTPSession()
    
    fileprivate var session: URLSession!
    
    fileprivate var requests    = [String]()
    fileprivate let queue       = OperationQueue()
    
    public override init() {
        super.init()
        session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: queue)
    }
    
    public func cancel(requestId: String?) {
        requests.remove(predicate: {$0 == requestId})
    }
    
    public func send<T:HTTPResponse>(request: HTTPRequest, _ handler: ((T) -> Void)?) {
        requests.append(request.id)
        request.logPrint()
        let task = session.dataTask(with: request.urlRequest) { [weak self] (data, urlResponse, error) in
            OperationQueue.main.addOperation { 
                if let index = self?.requests.index(of: request.id) {
                    self?.requests.remove(at: index)
                    let response = T(response: urlResponse as? HTTPURLResponse, data: data, error: error, isLoggingEnabled: request.isLoggingEnabled)
                    if request.shouldHandleCookies, let cookies = response.cookies {
                        HTTPCookieStorage.shared.setCookies(cookies, for: request.url, mainDocumentURL: nil)
                        if let items = HTTPCookieStorage.shared.cookies(for: request.url) {
                            let values = HTTPCookie.requestHeaderFields(with: items)
                            print(values)
                        }
                    }
                    response.logPrint()
                    handler?(response)
                }
            }
        }
        task.resume()
    }
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if let trust = challenge.protectionSpace.serverTrust {
            completionHandler(.useCredential, URLCredential(trust: trust))
        }
    }
    
}
