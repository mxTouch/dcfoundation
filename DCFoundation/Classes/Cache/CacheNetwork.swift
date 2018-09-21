//
//  DCFoundation
//

import Foundation

class CacheNetworkSessionTask: NSObject {
    public let identifier = NSUUID().uuidString
    
    open var onUpdate: ((_ bytesReady: Double, _ bytesTotal: Double) -> Void)?
    open var onComplete: ((_ value: Data?, _ error: NSError?) -> Void)?
    
    fileprivate var task: URLSessionTask?
    
    init(session: URLSession, url: URL) {
        super.init()
        task = session.downloadTask(with: url)
        task?.resume()
    }
    
    func process(bytesReady: Double, bytesTotal: Double) {
        onUpdate?(bytesReady, bytesTotal)
    }
    
    func finish(url: URL?, error: NSError?) {
        if let url = url {
            onComplete?(try? Data(contentsOf: url), error)
        } else {
            onComplete?(nil, error)
        }
    }
    
    open func cancel() {
        task?.cancel()
    }
    
}

class CacheNetworkSession: NSObject, URLSessionDownloadDelegate {
    
    fileprivate var session: URLSession!
    fileprivate let queue = OperationQueue()
    fileprivate var tasks = [CacheNetworkSessionTask]()
    
    override init() {
        super.init()
        queue.maxConcurrentOperationCount = 5
        session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: queue)
    }
    
    func performTask(url: String) -> CacheNetworkSessionTask? {
        guard let url = URL(string: url) else {return nil}
        tasks << CacheNetworkSessionTask(session: session, url: url)
        return tasks.last
    }
    
    // MARK - NSURLSessionDownloadDelegate
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let error = error as NSError? else {return}
        tasks.first(where: {$0.task == task})?.finish(url: nil, error: error as NSError?)
        tasks.remove(predicate: {$0.task == task})
        print("CACHE ERROR " + (task.originalRequest?.url?.absoluteString ?? "") + error.localizedDescription)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        tasks.first(where: {$0.task == downloadTask})?.finish(url: location, error: nil)
        tasks.remove(predicate: {$0.task == downloadTask})
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        tasks.first(where: {$0.task == downloadTask})?.process(bytesReady: Double(totalBytesWritten), bytesTotal: Double(totalBytesExpectedToWrite))
    }
    
}
