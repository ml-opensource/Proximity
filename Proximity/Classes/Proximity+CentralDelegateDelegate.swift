//
//  BluetoothManager+CentralDelegateDelegate.swift
//  Proximity
//
//  Created by Eric Kunz on 2/20/19.
//  Copyright © 2019 Fuzz. All rights reserved.
//

import CoreBluetooth

extension Proximity: CentralDelegateDelegate {
    
    func centralDidUpdateState(to state: CBManagerState) {
        switch state {
        case .poweredOn:
            self.state = .ready
        case .poweredOff:
            self.state = .initializing
            stopScanning()
            stopAdvertising()
            break
        default:
            break
        }
    }
    
    func centralDidDiscover(peripheral: CBPeripheral,
                            advertisementData: [String: Any],
                            rssi RSSI: NSNumber) {
        let periph = Peripheral(peripheral: peripheral, RSSI: RSSI, advertisementData: advertisementData)
        if let index = discoveredPeripherals.firstIndex(of: periph) {
            discoveredPeripherals.remove(at: index)
        }
        discoveredPeripherals.insert(periph)
        
        if RSSI.doubleValue > (immediateVicinityThreshold ?? Constants.defaultImmediateVicinityThreshold) {
            discoveredPeripherals.removeAll() // cleared so that the same peripheral doesn't trigger this again
            delegate?.proximityThresholdPassed(by: periph)
        }
    }
    
    func centralDidDisconnect(peripheral: CBPeripheral, error: Error?) {
        if let index = discoveredPeripherals.firstIndex(where: { $0.peripheral == peripheral }) {
            discoveredPeripherals.remove(at: index)
        }
    }
    
    func centralDidReadRSSI(peripheral: CBPeripheral, RSSI: NSNumber, error: Error?) {
        guard let index = discoveredPeripherals.firstIndex(where: { $0.peripheral == peripheral }) else {
            return
        }
        
        var periph = discoveredPeripherals[index]
        periph.RSSI = RSSI
        discoveredPeripherals.remove(at: index)
        discoveredPeripherals.insert(periph)
    }
    
}
