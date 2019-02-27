//
//  CBManagerStateExtensions.swift
//  Proximity
//
//  Created by Eric Kunz on 2/20/19.
//  Copyright © 2019 Fuzz. All rights reserved.
//

import CoreBluetooth

// used for debugging
extension CBManagerState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .poweredOff:
            return "powered off"
        case .poweredOn:
            return "powered on"
        case .resetting:
            return "resetting"
        case .unauthorized:
            return "unauthorized"
        case .unknown:
            return "unknown"
        case .unsupported:
            return "unsupported"
        }
    }
}
