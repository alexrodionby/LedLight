//
//  StatusView.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 9.12.23.
//

import SwiftUI
import CoreBluetooth

struct StatusView: View {
    
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        switch settingsViewModel.currentPeripheralState {
        case .disconnected:
            Text("Disconnected")
                .foregroundStyle(Color.red)
                .font(.caption)
        case .connecting:
            Text("Connecting")
                .foregroundStyle(Color.orange)
                .font(.caption)
        case .connected:
            Text("Connected")
                .foregroundStyle(Color.green)
                .font(.caption)
        case .disconnecting:
            Text("Disconnecting")
                .foregroundStyle(Color.orange)
                .font(.caption)
        @unknown default:
            Text("Unknown")
                .foregroundStyle(Color.orange)
                .font(.caption)
        }
    }
}

#Preview {
    StatusView(settingsViewModel: SettingsViewModel())
}
