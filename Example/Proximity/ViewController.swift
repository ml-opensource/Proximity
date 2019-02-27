//
//  ViewController.swift
//  Proximity
//
//  Created by Eric Kunz on 02/27/2019.
//  Copyright (c) 2019 Eric Kunz. All rights reserved.
//

import UIKit
import Proximity
import CoreBluetooth

class ViewController: UITableViewController {
    
    let proximityServiceUUID = "CAE21FDA-54F3-4439-AD7F-0B43EF8603C3"
    let proximityServiceUUID2 = "B4C910B8-46C0-4F95-8258-69E2E6F861F2"
    
    private let proximity = Proximity()
    
    private var discoveredPeripherals = [Peripheral]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        proximity.delegate = self
        
        addScanBarButtonItem()
        addAdvertiseBarButtonItem()
    }
    
    // MARK: - UITableviewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoveredPeripherals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "PeripheralCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ??
            UITableViewCell(style: .subtitle, reuseIdentifier: id)
        
        let peripheral = discoveredPeripherals[indexPath.row]
        cell.textLabel?.text = peripheral.name
        cell.detailTextLabel?.text = peripheral.RSSI.description
        
        return cell
    }
    
    // MARK: - Scan & Advertise
    
    @objc func scan() {
        addStopScanningBarButtonItem()
        navigationItem.leftBarButtonItem = nil
        
        proximity.startScanning(forPeripheralsWithServices: [proximityServiceUUID, proximityServiceUUID2])
    }
    
    @objc func advertise() {
        addStopAdvertisingBarButtonItem()
        navigationItem.rightBarButtonItem = nil
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let name = "iPad 📱"
            proximity.startAdvertising(name: name, services: [proximityServiceUUID])
        } else {
            let name = "iPhone 📱"
            proximity.startAdvertising(name: name, services: [proximityServiceUUID2])
        }
    }
    
    @objc func pause() {
        proximity.stopAdvertising()
        proximity.stopScanning()
        
        addScanBarButtonItem()
        addAdvertiseBarButtonItem()
    }
    
}

// MARK: - ProximityDelegate

extension ViewController: ProximityDelegate {
    func proximityDidUpdateState(_ proximity: Proximity) {
        title = proximity.state.description
    }
    
    func proximityDidUpdatePeripherals(_ proximity: Proximity) {
        self.discoveredPeripherals = proximity.discoveredPeripherals.sortedBySignalStrength()
    }
    
    func proximityThresholdPassed(by peripheral: Peripheral) {
        pause()
        
        print("🔷 Passed threshold", peripheral.advertisedServices ?? "")
        
        let popover = NearbyPeripheralPopover(peripheral: peripheral)
        present(popover, animated: true, completion: nil)
    }
    
}

// MARK: - Sorting Convenience

extension Collection where Element == Peripheral {
    func sortedBySignalStrength() -> [Self.Element] {
        return sorted(by: { (p1, p2) -> Bool in
            return p1.RSSI.doubleValue < p2.RSSI.doubleValue
        })
    }
}
