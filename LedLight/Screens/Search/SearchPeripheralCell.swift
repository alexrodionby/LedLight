//
//  SearchPeripheralCell.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 7.12.23.
//

import SwiftUI
import CoreBluetooth

struct SearchPeripheralCell: View {
    
    var peripheral: CBPeripheral?
    
    var body: some View {
        HStack {
            Text(peripheral?.name ?? "no name")
        }
        .frame(maxWidth: .infinity, minHeight: 50)
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.custom.gradientLeft, Color.custom.gradientRight]), startPoint: .leading, endPoint: .trailing)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.5), radius: 3, x: 2, y: 2)
    }
}

#Preview {
    SearchPeripheralCell()
}
