//
//  Color+Ext.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 7.12.23.
//

import Foundation
import SwiftUI

// Добавляем кастомные цвета к стандартным

extension Color {
    static let custom = CustomColors()
}

struct CustomColors {
    let background = Color("background")
    let gradientLeft = Color("gradientLeft")
    let gradientRight = Color("gradientRight")
}
