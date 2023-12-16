//
//  SearchView.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 7.12.23.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var settingsViewModel: SettingsViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.custom.background.ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 10) {
                Text("Available devices")
                    .font(.title)
                    .padding(.top)
                
                ScrollView {
                    ForEach(settingsViewModel.peripherals, id: \.identifier) { peripheral in
                        SearchPeripheralCell(peripheral: peripheral)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .onTapGesture {
                                settingsViewModel.stopScanForPeripherals()
                                settingsViewModel.connectToCurrentPeripheral(peripheral: peripheral)
                                settingsViewModel.savePeripheralToStorageList(peripheral: peripheral)
                                isPresented = false
                            }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            settingsViewModel.startScanForPeripherals()
        }
        .onDisappear {
            settingsViewModel.stopScanForPeripherals()
        }
    }
}

#Preview {
    SearchView(settingsViewModel: SettingsViewModel(), isPresented: .constant(true))
}
