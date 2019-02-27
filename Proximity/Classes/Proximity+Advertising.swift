//
//  BluetoothManager+Advertising.swift
//  Proximity
//
//  Created by Eric Kunz on 2/20/19.
//  Copyright © 2019 Fuzz. All rights reserved.
//

import CoreBluetooth
import CoreLocation

extension Proximity {
    
    /**
     Begins to advertise. Only advertise when necessary and
     call `stopAdvertising` when finished to preserve battery life.
     
     - Parameter name: The name to display to other devices.
     - Parameter services: The available services to display. Services should follow
                           UUID format (XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX).
     
     - Warning: Wait to call this method until `Proximity.state` is `ready`.
     */
    public func startAdvertising(name: String, services: [String]? = nil) {
        var ad: [String: Any] = [CBAdvertisementDataLocalNameKey: name as NSString]
        
        if let services = services {
            let UUIDs = services.map { CBUUID(string: $0) }
            ad[CBAdvertisementDataServiceUUIDsKey] = NSArray(array: UUIDs)
        }
        
        peripheral.startAdvertising(ad)
        
        state = .advertising
    }
    
    /// Begins to advertise as an iBeacon.
    public func startAdvertisingBeacon(proximityUUID: UUID,
                                 major: CLBeaconMajorValue,
                                 minor: CLBeaconMinorValue,
                                 beaconID: String,
                                 deviceName: String) {
        guard central.state == .poweredOn else {
            fatalError("BluetoothManager not yet ready to advertise. Wait until delegate gets bluetoothManagerBecameReady() call.")
        }
        
        let region = CLBeaconRegion(proximityUUID: proximityUUID,
                                    major: major,
                                    minor: minor,
                                    identifier: beaconID)
        
        advertiseDevice(region: region, name: deviceName)
        
        state = .advertising
    }
    
    private func advertiseDevice(region: CLBeaconRegion, name: String) {
        guard var peripheralData = region.peripheralData(withMeasuredPower: nil) as? [String: Any] else { return }
        
        peripheralData[CBAdvertisementDataLocalNameKey] = name as NSString
        
        peripheral.startAdvertising(peripheralData)
    }
    
    /// Stops advertising.
    public func stopAdvertising() {
        peripheral.stopAdvertising()
        state = .ready
    }
    
}
