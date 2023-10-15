//
//  ContentView.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/1.
//

import SwiftUI

struct ContentView: View {
    @StateObject var mc = MCManager()
    @State private var selection: Tab = .discover
    
    enum Tab {
        case chat
        case discover
        case profile
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ChatView()
                .environmentObject(mc)
                .tabItem {
                    Label("Chat", systemImage: "message.circle")
                }
                .tag(Tab.chat)
            
            DiscoverView()
                .environmentObject(mc)
                .tabItem {
                    Label("Discover", systemImage: "wifi.square")
                }
                .tag(Tab.discover)
            
            ProfileView()
                .environmentObject(mc)
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
                .tag(Tab.profile)
        }
        .onAppear() {
            UITabBar.appearance().backgroundColor = .quaternarySystemFill
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
