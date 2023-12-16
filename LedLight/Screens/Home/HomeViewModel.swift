//
//  HomeViewModel.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 9.12.23.
//

import Foundation
import Combine
import CoreBluetooth

class HomeViewModel: ObservableObject {
    
    private var manager: BluetoothManager = .shared
    private var storage: StorageService = .shared
    private var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: - Lifecycle
    
    deinit {
        cancellables.cancel()
    }
    
    // MARK: - Init
    
    init() {
        
    }
    
    // MARK: - Public Methods
    
}
