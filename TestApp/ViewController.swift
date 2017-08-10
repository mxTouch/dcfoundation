//
//  ViewController.swift
//  TestApp
//
//  Created by Igor Danich on 01/12/2016.
//  Copyright © 2016 Igor Danich. All rights reserved.
//

import UIKit
import MPFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationAdd(observer: self, name: .UIApplicationWillResignActive) { ntf in
            print("yes")
        }
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            NotificationPost(name: .UIApplicationWillResignActive)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
