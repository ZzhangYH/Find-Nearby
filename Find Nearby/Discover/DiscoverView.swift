//
//  DiscoverView.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/2.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var mc: MCManager
    
    @State private var showInvitations = false
    @State private var isBrowsing = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                GeometryReader { geometry in
                    let count = mc.foundPeers.count
                    let numOfHS = Int(ceil(Double(count) / 2))
                    
                    VStack {
                        Toggle("Browsing nearby devices", isOn: $mc.isBrowsing)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        ForEach(0...numOfHS, id: \.self) { num in
                            let index = num * 2

                            HStack {
                                Spacer()

                                if index < count {
                                    PeerGrid(peerID: mc.foundPeers[index])
                                        .environmentObject(mc)
                                        .scaleEffect(geometry.size.width / 393)
                                        .padding(.horizontal, geometry.size.width * 0.01)
                                }
                                if index + 1 < count {
                                    PeerGrid(peerID: mc.foundPeers[index + 1])
                                        .environmentObject(mc)
                                        .scaleEffect(geometry.size.width / 393)
                                        .padding(.horizontal, geometry.size.width * 0.01)
                                }

                                Spacer()
                            }
                            .padding(.vertical, geometry.size.height * 0.01)
                        }
                    }
                }
                .padding()
                .navigationTitle("Find Nearby")
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(MCManager())
    }
}
