//
//  SettingsViewModel.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 7.12.23.
//

import Foundation
import CoreBluetooth
import Combine

class SettingsViewModel: ObservableObject {
    
    private var manager: BluetoothManager = .shared
    private var storage: StorageService = .shared
    private var cancellables: Set<AnyCancellable> = .init()
    
    @Published var peripherals: [CBPeripheral] = .init()
    @Published var currentPeripheral: CBPeripheral?
    @Published var currentPeripheralState: CBPeripheralState = .disconnected
    @Published var savedPeripheralsList: [PeripheralData] = .init()
    
    // MARK: - Lifecycle
    
    deinit {
        cancellables.cancel()
    }
    
    // MARK: - Init
    
    init() {
        manager.discoveredPeripheral
            .filter { [weak self] in self?.peripherals.contains($0) == false }
            .sink { [weak self] peripheral in
                self?.peripherals.append(peripheral)
                self?.peripherals.sort { (left, right) in
                    if let leftName = left.name, let rightName = right.name {
                        return leftName < rightName
                    } else if left.name != nil {
                        return true
                    } else {
                        return false
                    }
                }
            }
            .store(in: &cancellables)
        
        manager.currentPeripheral
            .assign(to: &$currentPeripheral)
        
        manager.currentPeripheralState
            .assign(to: &$currentPeripheralState)
        
        savedPeripheralsList = storage.loadPeripheralsList(nameOfPeripheralsList: StorageKeys.peripheralsList.rawValue) ?? []
    }
    
    // MARK: - Public Methods
    
    func startScanForPeripherals() {
        manager.startScanPeripherals()
    }
    
    func stopScanForPeripherals() {
        manager.stopScanPeripherals()
    }
    
    func connectToCurrentPeripheral(peripheral: CBPeripheral) {
        manager.connectPeripheral(peripheral: peripheral)
    }
    
    func savePeripheralToStorageList(peripheral: CBPeripheral) {
        storage.savePeripheralToStorage(peripheral: PeripheralData(uuid: peripheral.identifier.uuidString, name: peripheral.name ?? "No Device Name"), name: StorageKeys.peripheralsList.rawValue)
        loadSavedPeripheralsList()
    }

    func loadSavedPeripheralsList() {
        savedPeripheralsList = storage.loadPeripheralsList(nameOfPeripheralsList: StorageKeys.peripheralsList.rawValue) ?? []
    }
    
    func removePeripheralFromSavedList(peripheral: PeripheralData) {
        storage.removePeripheral(peripheral: peripheral, name: StorageKeys.peripheralsList.rawValue)
        loadSavedPeripheralsList()
    }
    
    func clearPeripheralsSavedList() {
        storage.deletePeripheralsList(nameOfPeripheralsList: StorageKeys.peripheralsList.rawValue)
        savedPeripheralsList = []
    }
}
