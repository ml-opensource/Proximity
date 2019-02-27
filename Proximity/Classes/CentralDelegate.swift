//
//  CentralDelegate.swift
//  Proximity
//
//  Created by Eric Kunz on 2/20/19.
//  Copyright © 2019 Fuzz. All rights reserved.
//

import CoreBluetooth

protocol CentralDelegateDelegate: AnyObject {
    func centralDidUpdateState(to state: CBManagerState)
    func centralDidDiscover(peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber)
    func centralDidDisconnect(peripheral: CBPeripheral, error: Error?)
    func centralDidReadRSSI(peripheral: CBPeripheral, RSSI: NSNumber, error: Error?)
}

// This class is used because CBCentralManagerDelegate.centralManagerDidUpdateState(_:) is
// declared as public but I do not want consumers of Proximity to see that conformance.
final class CentralDelegate: NSObject, CBCentralManagerDelegate {
    
    weak var delegate: CentralDelegateDelegate?
    
    // MARK: - CBCentralManagerDelegate
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        delegate?.centralDidUpdateState(to: central.state)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        delegate?.centralDidDiscover(peripheral: peripheral, advertisementData: advertisementData, rssi: RSSI)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {}
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {}
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        delegate?.centralDidDisconnect(peripheral: peripheral, error: error)
    }
    
    // MARK: - CBPeripheralDelegate
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        delegate?.centralDidReadRSSI(peripheral: peripheral, RSSI: RSSI, error: error)
    }
    
}
