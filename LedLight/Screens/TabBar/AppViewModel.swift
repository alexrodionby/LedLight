//
//  AppViewModel.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 9.12.23.
//

import Foundation
import Combine
import CoreBluetooth

class AppViewModel: ObservableObject {
    
    private var manager: BluetoothManager = .shared
    private var storage: StorageService = .shared
    private var cancellables: Set<AnyCancellable> = .init()
    
    @Published var centarlManagerState: CBManagerState = .unknown
    @Published var currentPeripheralState: CBPeripheralState = .disconnected
    @Published var currentPeripheral: CBPeripheral?
    
    
    // MARK: - Lifecycle
    
    deinit {
        cancellables.cancel()
    }
    
    // MARK: - Init
    
    init() {
        manager.centralManagerState
            .assign(to: &$centarlManagerState)
        
        manager.currentPeripheral
            .assign(to: &$currentPeripheral)

        manager.currentPeripheralState
            .assign(to: &$currentPeripheralState)

        manager.startCentralManager()
    }
}
