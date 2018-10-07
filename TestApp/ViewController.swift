//
//  ViewController.swift
//  TestApp
//

import UIKit
import DCFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = HTTPRequest(url: URL(string: "http://google.com")!)
        request.shouldHandleCookies = true
        HTTPSession.shared.send(request: request) { (response) in
            print(response)
        }
    }


}
