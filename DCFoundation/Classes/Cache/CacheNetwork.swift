//
//  CacheNetwork.swift
//  MPFoundation
//
//  Created by Igor Danich on 07/11/2016.
//  Copyright © 2016 Igor Danich. All rights reserved.
//

import Foundation

class CacheNetworkSessionTask: NSObject {
    open let identifier = NSUUID().uuidString
    
    open var onUpdate: ((_ bytesReady: Double, _ bytesTotal: Double) -> Void)?
    open var onComplete: ((_ value: Data?, _ error: NSError?) -> Void)?
    
    fileprivate var task: URLSessionTask?
    
    init(session: URLSession, url: URL) {
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
        let task = CacheNetworkSessionTask(session: session, url: url)
        tasks << task
        return task
    }
    
    // MARK - NSURLSessionDownloadDelegate
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let index = tasks.index(where: {$0.task == task}) else {return}
        tasks[safe: index]?.finish(url: nil, error: error as? NSError)
        if index < tasks.count {tasks.remove(at: index)}
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let index = tasks.index(where: {$0.task == downloadTask}) else {return}
        tasks[safe: index]?.finish(url: location, error: nil)
        if index < tasks.count {tasks.remove(at: index)}
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard let index = tasks.index(where: {$0.task == downloadTask}) else {return}
        tasks[safe: index]?.process(bytesReady: Double(totalBytesWritten), bytesTotal: Double(totalBytesExpectedToWrite))
    }
    
}
