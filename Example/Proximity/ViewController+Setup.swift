//
//  ViewController+Setup.swift
//  Proximity_Example
//
//  Created by Eric Kunz on 2/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

extension ViewController {
    
    func addScanBarButtonItem() {
        let scanButton = UIBarButtonItem(title: "Scan",
                                         style: .plain,
                                         target: self,
                                         action: #selector(ViewController.scan))
        navigationItem.rightBarButtonItem = scanButton
    }
    
    func addAdvertiseBarButtonItem() {
        let advertiseButton = UIBarButtonItem(title: "Advertise",
                                              style: .plain,
                                              target: self,
                                              action: #selector(ViewController.advertise))
        navigationItem.leftBarButtonItem = advertiseButton
    }
    
    func addStopScanningBarButtonItem() {
        let pauseButton = UIBarButtonItem(barButtonSystemItem: .pause,
                                          target: self,
                                          action: #selector(ViewController.pause))
        navigationItem.rightBarButtonItem = pauseButton
    }
    
    func addStopAdvertisingBarButtonItem() {
        let pauseButton = UIBarButtonItem(barButtonSystemItem: .pause,
                                          target: self,
                                          action: #selector(ViewController.pause))
        navigationItem.leftBarButtonItem = pauseButton
    }
    
}
