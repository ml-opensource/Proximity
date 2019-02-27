//
//  Peripheral.swift
//  Proximity
//
//  Created by Eric Kunz on 2/19/19.
//  Copyright © 2019 Eric Kunz. All rights reserved.
//

import CoreBluetooth

/// received signal strength indicator
public typealias RSSI = NSNumber

/// Represents a bluetooth device. Mostly a wrapper for a `CBPeripheral` found in the
/// `peripheral` property.
public struct Peripheral {
    /// The object returned from CoreBluetooth.
	public let peripheral: CBPeripheral
    /// The signal strength.
	public var RSSI: RSSI
    /// Check `CBAdvertisementData` for possible keys.
	public let advertisementData: [String : Any]
}

// MARK: - Extensions

extension Peripheral: Equatable {
	public static func == (lhs: Peripheral, rhs: Peripheral) -> Bool {
		return lhs.peripheral == rhs.peripheral
	}
}

extension Peripheral: Hashable {
	public var hashValue: Int {
		return peripheral.hashValue
	}
}

public extension Peripheral {
    public var advertisedServices: [String]? {
        guard let services = advertisementData[CBAdvertisementDataServiceUUIDsKey] as? [CBUUID] else { return nil }
        
        return services.map { $0.uuidString }
    }
    
	/// The Tx power level
	public var transmitPower: Double? {
		return advertisementData[CBAdvertisementDataTxPowerLevelKey] as? Double
	}
	
    /// The name of the device.
	public var name: String? {
		return peripheral.name ?? advertisementData[CBAdvertisementDataLocalNameKey] as? String
	}
	
    /// The manufacturer data. Returns the value of `CBAdvertisementDataManufacturerDataKey`
    /// from the `advertisementData`.
	public var manufacturerData: Data? {
		return advertisementData[CBAdvertisementDataManufacturerDataKey] as? Data
	}
}
