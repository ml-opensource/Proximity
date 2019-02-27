//
//  Test.swift
//  Proximity
//
//  Created by Eric Kunz on 2/21/19.
//  Copyright © 2019 Fuzz. All rights reserved.
//

import Foundation

public protocol ProximityDelegate: AnyObject {
    func proximityDidUpdateState(_ proximity: Proximity)
    func proximityDidUpdatePeripherals(_ proximity: Proximity)
    func proximityThresholdPassed(by peripheral: Peripheral)
}
