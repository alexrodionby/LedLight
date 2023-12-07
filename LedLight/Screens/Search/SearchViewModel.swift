//
//  SearchViewModel.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 7.12.23.
//

import Foundation
import CoreBluetooth
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var peripherals: [CBPeripheral] = []
    
    private lazy var manager: BluetoothManager = .shared
    private lazy var cancellables: Set<AnyCancellable> = .init()
    
    
    // MARK: - Lifecycle
    
    deinit {
        cancellables.cancel()
    }
    
    // MARK: - Public Methods
    
    func startScanForPeripherals() {
        
        manager.centralManagerState
            .sink { [weak self] state in
                if state == .poweredOn {
                    self?.manager.startScanPeripherals()
                }
            }
            .store(in: &cancellables)
        
        manager.peripheralsList
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
        
        manager.startCentralManager()
    }
    
    func stopScanForPeripherals() {
        manager.stopScanPeripherals()
    }
}
