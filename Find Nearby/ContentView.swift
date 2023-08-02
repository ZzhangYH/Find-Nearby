//
//  ContentView.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/1.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .discover
    
    enum Tab {
        case chat
        case discover
        case profile
    }
    
    var body: some View {
        TabView(selection: $selection) {
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "wifi.square")
                }
                .tag(Tab.discover)
            
            ProfileView(profile: testProfiles[0])
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
                .tag(Tab.profile)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
