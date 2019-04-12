//
//  Service.swift
//  Pods-Proximity_Example
//
//  Created by Eric Kunz on 3/1/19.
//

import CoreBluetooth

/// Represents either an advertised BLE service or the service of a peripheral.
struct Service {
    let peripheral: CBPeripheral
    let isPrimary: Bool
    let includedServices: [Service]?
    let characteristics: [Characteristic]?
}

extension Service {
    init(_ service: CBService) {
        self.peripheral = service.peripheral
        self.isPrimary = service.isPrimary
        self.includedServices = service.includedServices?.map { Service($0) }
        self.characteristics = service.characteristics?.map { Characteristic($0) }
    }
}


struct Characteristic {
    let service: Service
    let properties: CBCharacteristicProperties
    public let value: Data?
    let descriptors: [CBDescriptor]?
    let isNotifying: Bool
}

extension Characteristic {
    init(_ charactersitic: CBCharacteristic) {
        self.service = Service(charactersitic.service)
        self.properties = charactersitic.properties
        self.value = charactersitic.value
        self.descriptors = charactersitic.descriptors
        self.isNotifying = charactersitic.isNotifying
    }
}
