//
//  SavedPeripheralCell.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 9.12.23.
//

import SwiftUI

struct SavedPeripheralCell: View {
    
    var savedPeripheral: PeripheralData?
    var onDelete: (() -> Void)?
    
    var body: some View {
        if savedPeripheral == nil {
            Text("No Devices")
                .padding(.horizontal)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background {
                    LinearGradient(gradient: Gradient(colors: [Color.custom.gradientLeft, Color.custom.gradientRight]), startPoint: .leading, endPoint: .trailing)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.5), radius: 3, x: 2, y: 2)
        } else {
            HStack {
                Text(savedPeripheral?.name ?? "Unknown")
                    .padding(.horizontal)
                Spacer()
                Button(action: {
                    onDelete?()
                }) {
                    Image(systemName: "trash")
                }
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
    SavedPeripheralCell()
        .padding()
}
