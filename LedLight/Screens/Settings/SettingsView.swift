//
//  SettingsView.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 7.12.23.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var appViewModel: AppViewModel
    @StateObject private var settingsViewModel: SettingsViewModel = .init()
    
    @State private var isPeripheralSearchPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.custom.background.ignoresSafeArea()
                VStack {
                    VStack(alignment: .leading) {
                        Text("Current peripheral")
                            .font(.headline)
                            .padding(.horizontal)
                        SettingsPeripheralCell(settingsViewModel: settingsViewModel)
                            .padding(.horizontal)
                        Divider()
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Saved peripherals")
                                .font(.headline)
                                .padding(.horizontal)
                            Spacer()
                            Button("Clear") {
                                settingsViewModel.clearPeripheralsSavedList()
                            }
                            .padding(.horizontal)
                        }
                        if settingsViewModel.savedPeripheralsList.count == 0 {
                            SavedPeripheralCell(savedPeripheral: nil)
                                .padding(.horizontal)
                        } else {
                            ScrollView {
                                ForEach(settingsViewModel.savedPeripheralsList, id: \.uuid) { peripheral in
                                    SavedPeripheralCell(savedPeripheral: peripheral) {
                                        settingsViewModel.removePeripheralFromSavedList(peripheral: peripheral)
                                    }
                                    .padding(.horizontal)
                                    .onTapGesture {
                                        print("Нажали на ячейку")
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add peripheral") {
                        isPeripheralSearchPresented = true
                    }
                }
            }
            .sheet(isPresented: $isPeripheralSearchPresented) {
                SearchView(settingsViewModel: settingsViewModel, isPresented: $isPeripheralSearchPresented)
            }
        }
    }
}

#Preview {
    SettingsView(appViewModel: AppViewModel())
}
