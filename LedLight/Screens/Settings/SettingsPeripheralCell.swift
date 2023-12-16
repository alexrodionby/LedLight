//
//  SettingsPeripheralCell.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 8.12.23.
//

import SwiftUI
import CoreBluetooth

struct SettingsPeripheralCell: View {
    
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        if settingsViewModel.currentPeripheral == nil {
            HStack {
                Text("No connected device")
                    .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .background {
                LinearGradient(gradient: Gradient(colors: [Color.custom.gradientLeft, Color.custom.gradientRight]), startPoint: .leading, endPoint: .trailing)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.5), radius: 3, x: 2, y: 2)
        } else {
            HStack {
                Text(settingsViewModel.currentPeripheral?.name ?? "No Device Name")
                    .padding(.horizontal)
                Spacer()
                StatusView(settingsViewModel: settingsViewModel)
                    .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .background {
                LinearGradient(gradient: Gradient(colors: [Color.custom.gradientLeft, Color.custom.gradientRight]), startPoint: .leading, endPoint: .trailing)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.5), radius: 3, x: 2, y: 2)
        }
    }
}

#Preview {
    SettingsPeripheralCell(settingsViewModel: SettingsViewModel())
        .padding()
}
