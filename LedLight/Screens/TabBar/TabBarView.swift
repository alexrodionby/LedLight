//
//  TabBarView.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 7.12.23.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab: Int = Tabs.tab1.tag
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("\(Tabs.tab1.labelName)", systemImage: Tabs.tab1.labelIcon)
                }
                .tag(Tabs.tab1.tag)
            SettingsView()
                .tabItem {
                    Label("\(Tabs.tab2.labelName)", systemImage: Tabs.tab2.labelIcon)
                }
                .tag(Tabs.tab2.tag)
        }
    }
}

enum Tabs {
    case tab1
    case tab2
    
    var labelName: LocalizedStringResource {
        switch self {
        case .tab1:
            return "Home"
        case .tab2:
            return "Settings"
        }
    }
    
    var labelIcon: String {
        switch self {
        case .tab1:
            return "house"
        case .tab2:
            return "gearshape"
        }
    }
    
    var tag: Int {
        switch self {
        case .tab1:
            return 1
        case .tab2:
            return 2
        }
    }
}

#Preview {
    TabBarView()
}
