//
//  LedLightApp.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 7.12.23.
//

import SwiftUI

@main
struct LedLightApp: App {
    
    @StateObject private var appViewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabBarView(appViewModel: appViewModel)
                .preferredColorScheme(.dark)
        }
    }
}
