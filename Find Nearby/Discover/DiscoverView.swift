//
//  DiscoverView.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/2.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var mc: MCManager
    @State private var isBrowsing = true
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                DiscoverController(isBrowsing: mc.isBrowsing)
                    .environmentObject(mc)
                
                GeometryReader { geometry in
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(mc.foundPeers, id: \.self) { peerID in
                                PeerGrid(peerID: peerID)
                                    .environmentObject(mc)
                                    .scaleEffect(geometry.size.width / 393)
                            }
                        }
                        .padding()
                    }
                }
                
                Divider()
                
                DiscoverStatus()
                    .environmentObject(mc)
            }
            .padding()
            .navigationTitle("Find Nearby")
        }
    }
}

struct DiscoverController: View {
    @EnvironmentObject var mc: MCManager
    @State var isBrowsing: Bool
    
    var body: some View {
        let toggleBinding = Binding {
            mc.isBrowsing
        } set: {
            mc.isBrowsing = $0
            self.isBrowsing = $0
        }
        HStack {
            Text("Browsing nearby devices  ").foregroundColor(.secondary)
            if isBrowsing && mc.profile.isAdvertising {
                ProgressView()
            }
            
            Spacer()
            
            Toggle("Browsing nearby devices", isOn: toggleBinding).labelsHidden()
        }
        .padding(.horizontal)
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(MCManager())
    }
}
