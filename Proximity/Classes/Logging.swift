//
//  Logging.swift
//  Proximity
//
//  Created by Eric Kunz on 2/20/19.
//  Copyright © 2019 Fuzz. All rights reserved.
//

import os

// only do this if a launch argument is set?
func osLog(_ message: String, as type: OSLogType) {
    if #available(iOS 12.0, *) {
        let bundleID = Bundle(for: Proximity.self).bundleIdentifier ?? "unknown"
        let log = OSLog(subsystem: bundleID, category: "Proximity")
        os_log(type, log: log, "%{public}@", message)
    }
}
