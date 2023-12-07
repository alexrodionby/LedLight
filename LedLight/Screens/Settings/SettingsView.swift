//
//  SettingsView.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 7.12.23.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var settingsViewModel: SettingsViewModel = .init()
    @State private var isPeripheralSearchPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.custom.background.ignoresSafeArea()
                Form {
                    Section("Current peripheral") {
                        Text("Some peripheral")
                    }
                    
                    Section("Last peripheral") {
                        Text("Some peripheral")
                    }
                    
                    Section("Saved peripheral") {
                        Text("Some peripheral")
                    }
                }
                .background {
                    Color.custom.background
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
                SearchView()
            }
        }
    }
}

#Preview {
    SettingsView()
}
