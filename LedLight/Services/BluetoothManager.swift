//
//  BluetoothManager.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 7.12.23.
//

import Foundation
import CoreBluetooth
import Combine

final class BluetoothManager: NSObject {
    
    static let shared: BluetoothManager = .init()
    private override init() {}
    
    private var centralManager: CBCentralManager?
    
    var centralManagerState: PassthroughSubject<CBManagerState, Never> = .init()
    var peripheralsList: PassthroughSubject<CBPeripheral, Never> = .init()
    
    // MARK: - Public Methods
    
    // Старт работы менеджера блютус устройств
    func startCentralManager() {
        centralManager = CBCentralManager(delegate: self, queue: .main, options: nil)
    }
    
    // Старт сканирования устройст
    func startScanPeripherals() {
        centralManager?.scanForPeripherals(withServices: nil, options: nil)
    }
    
    // Стоп сканирования устройств
    func stopScanPeripherals() {
        centralManager?.stopScan()
    }
    
}

// MARK: - extension BluetoothManager CBCentralManagerDelegate

extension BluetoothManager: CBCentralManagerDelegate {
    
    // Возвращает состояние блютуса телефона
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        centralManagerState.send(central.state)
    }
    
    // Возвращает найденное устройство и информацию о нем
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral.identifier.uuidString)
        peripheralsList.send(peripheral)
    }
    
    
}

// MARK: - extension BluetoothManager CBPeripheralDelegate

extension BluetoothManager: CBPeripheralDelegate {
    
}
