//
//  HomeView.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 7.12.23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var appViewModel: AppViewModel
    @StateObject private var homeViewModel: HomeViewModel = .init()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.custom.background.ignoresSafeArea()
                if appViewModel.currentPeripheral?.identifier.uuidString == Constants.deviceUUID {
                    // экран устройства
                } else {
                    if let peripheral = appViewModel.currentPeripheral {
                        Text(peripheral.name ?? "No Device Name")
                    } else {
                        Text("No Device Connected")
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(appViewModel: AppViewModel())
}
