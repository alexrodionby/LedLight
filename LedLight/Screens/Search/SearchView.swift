//
//  SearchView.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 7.12.23.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var searchViewModel: SearchViewModel = .init()
    
    var body: some View {
        ZStack {
            Color.custom.background.ignoresSafeArea()
            VStack(alignment: .center, spacing: 10) {
                Text("Available devices")
                    .font(.title)
                    .padding(.top)
                ScrollView {
                    ForEach(searchViewModel.peripherals, id: \.identifier) { peripheral in
                        SearchPeripheralCell(peripheral: peripheral)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            searchViewModel.startScanForPeripherals()
        }
        .onDisappear {
            searchViewModel.stopScanForPeripherals()
        }
    }
}

#Preview {
    SearchView()
}
