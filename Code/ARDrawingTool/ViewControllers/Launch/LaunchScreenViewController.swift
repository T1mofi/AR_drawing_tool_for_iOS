//
//  LaunchScreenViewController.swift
//  ARDrawingTool
//
//  Created by Tsimafei's Study on 4/18/20.
//  Copyright © 2020 Tsimafei's Study. All rights reserved.
//

import UIKit

// This class is writen for future use
class LaunchScreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}

// MARK: Private functions
extension LaunchScreenViewController {
    var isFirstLaunch: Bool {
        if UserDefaults.standard.bool(forKey: "isNotFirstLaunch") {
            return false
        } else {
            UserDefaults.standard.set(true, forKey: "isNotFirstLaunch")
            return true
        }
    }
}

