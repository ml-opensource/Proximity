//
//  BluetoothManager+Scanning.swift
//  Proximity
//
//  Created by Eric Kunz on 2/20/19.
//  Copyright © 2019 Fuzz. All rights reserved.
//

import CoreBluetooth

extension Proximity {
    
    /**
     Begins to scan for BLE devices. Only scan when necessary and
     call `stopScanning` when finished to preserve battery life.
     
     - Parameter serviceUUIDs: Filter the discovered devices to only those with the specified
     services. Services should follow UUID format (XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX).
     - Parameter autoUpdateRSSI: If `true`, the `discoveredPeripherals` will update every time an
     advertise packet is received in order to get the latest RSSI. This option
     negatively affects battery life.
     
     - Warning: Wait to call this method until `Proximity.state` is `ready`.     
     */
    public func startScanning(forPeripheralsWithServices serviceUUIDs: [String]? = nil, autoUpdateRSSI: Bool = false) {
        guard central.state == .poweredOn else {
            fatalError("BluetoothManager not yet ready to scan. Wait until delegate gets bluetoothManagerBecameReady() call.")
        }
        
        guard state != .scanning else {
            print("Called \(#function) while already scanning.")
            return
        }
        
        // This option negtively affects battery life but is required for RSSI updates.
        var options = [String: Any]()
        
        if autoUpdateRSSI {
            options[CBCentralManagerScanOptionAllowDuplicatesKey] = NSNumber(booleanLiteral: true)
        }
        
        let cbUUIDs = serviceUUIDs?.map { CBUUID(string: $0) }
        
        central.scanForPeripherals(withServices: cbUUIDs, options: options)
        
        state = .scanning
    }
    
    /// Stops scanning for peripherals.
    public func stopScanning() {
        guard central.isScanning else { return }
        
        central.stopScan()
        state = .ready
    }
    
}
