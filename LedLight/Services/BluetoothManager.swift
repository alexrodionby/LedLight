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
    
    private var storage: StorageService = .shared
    
    private var centralManager: CBCentralManager?
    private var cancellables: Set<AnyCancellable> = .init()
    
    var centralManagerState: CurrentValueSubject<CBManagerState, Never> = .init(.unknown)
    var discoveredPeripheral: PassthroughSubject<CBPeripheral, Never> = .init()
    var currentPeripheral: PassthroughSubject<CBPeripheral?, Never> = .init()
    var currentPeripheralState: CurrentValueSubject<CBPeripheralState, Never> = .init(.disconnected)
    
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
    
    // Коннектимся к устройству
    func connectPeripheral(peripheral: CBPeripheral) {
        currentPeripheralState.send(peripheral.state)
        currentPeripheral.send(peripheral)
        centralManager?.connect(peripheral, options: nil)
    }
    
    // Отсоединяемся от устройства
    func disconnectPeripheral(peripheral: CBPeripheral) {
        currentPeripheralState.send(peripheral.state)
        currentPeripheral.send(peripheral)
        centralManager?.cancelPeripheralConnection(peripheral)
    }
    
    // Коннектимся к устройству по UUID
    func connectPeripheralwithUUID(uuid: String) {
        self.discoveredPeripheral
            .sink { [weak self] peripheral in
                print("uuid id", peripheral.identifier.uuidString)
                if peripheral.identifier.uuidString == uuid {
                    self?.centralManager?.stopScan()
                    self?.centralManager?.connect(peripheral, options: nil)
                    self?.currentPeripheral.send(peripheral)
                }
            }
            .store(in: &cancellables)
        
        startScanPeripherals()
    }
    
}

// MARK: - extension BluetoothManager CBCentralManagerDelegate

extension BluetoothManager: CBCentralManagerDelegate {
    
    // Возвращает состояние блютуса телефона (после startCentralManager)
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        centralManagerState.send(central.state)
    }
    
    // Возвращает найденное устройство и информацию о нем (после startScanPeripherals)
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        discoveredPeripheral.send(peripheral)
    }
    
    // Срабатывает после подключения к устройству
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        currentPeripheral.send(peripheral)
        currentPeripheralState.send(peripheral.state)
        storage.saveLastPeripheral(peripheral: PeripheralData(uuid: peripheral.identifier.uuidString, name: peripheral.name ?? "No Device Name"), name: StorageKeys.lastPeripheral.rawValue)
    }
    
    // Срабатывает после отключения от устройства
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        currentPeripheral.send(nil)
        currentPeripheralState.send(peripheral.state)
    }
    
    //    // Читаем значение характеристики
    //    func readValueForCharacteristic(peripheral: CBPeripheral, characteristic: CBCharacteristic) {
    //        peripheral.readValue(for: characteristic)
    //    }
    
    
}

// MARK: - extension BluetoothManager CBPeripheralDelegate

extension BluetoothManager: CBPeripheralDelegate {
    
    
    
}
