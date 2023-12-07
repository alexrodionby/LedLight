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
    
    
    private lazy var manager: BluetoothManager = .shared
    private lazy var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: - Public Methods
    
    
}
