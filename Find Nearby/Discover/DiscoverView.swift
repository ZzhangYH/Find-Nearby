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
    
    var body: some View {
        NavigationView {
            VStack {
                DiscoverController(isBrowsing: mc.isBrowsing)
                
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
            }
            .padding()
            .navigationTitle("Find Nearby")
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(MCManager())
    }
}
