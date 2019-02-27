//
//  BluetoothManager.swift
//  Proximity
//
//  Created by Eric Kunz on 2/20/19.
//  Copyright © 2019 Fuzz. All rights reserved.
//

import CoreBluetooth

/**
 Proximity tracks discovered BLE devices.
 */
public final class Proximity: NSObject {
	
    // MARK: - Types
    
    struct Constants {
        /// The default threshold for determing when a device is in the immediate
        /// vicinity based on its signal strength (RSSI).
        static let defaultImmediateVicinityThreshold: Double = -40
    }
    
    // MARK: - Properties
	
	public weak var delegate: ProximityDelegate?
	
	// For scanning
	let central = CBCentralManager(delegate: nil, queue: nil)
	// For advertising
	let peripheral = CBPeripheralManager(delegate: nil, queue: nil)
	
    /// The found BLE peripherals. Updated every time an advertising packet is received
    /// from new or already discovered peripherals.
    public var discoveredPeripherals = Set<Peripheral>() {
        didSet {
            delegate?.proximityDidUpdatePeripherals(self)
        }
    }
    
    /**
     The RSSI used to determine immediate vicinity. Any RSSI values greater
     than this will be considred immediate.
     
     - Note:
     Uses the default (-40) when nil.
     */
    public var immediateVicinityThreshold: Double? = Constants.defaultImmediateVicinityThreshold
	
	public internal(set) var state: State = .initializing {
		didSet {
            guard state != oldValue else { return }
            
            osLog("State changed to \(state).", as: .info)
			delegate?.proximityDidUpdateState(self)
		}
	}
    
    let centralDelegate = CentralDelegate()
	
	// MARK: - Initialization
	
    public override init() {
        super.init()
        
        central.delegate = centralDelegate
        centralDelegate.delegate = self
    }
    
}
