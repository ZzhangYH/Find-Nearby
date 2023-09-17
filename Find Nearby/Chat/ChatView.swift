//
//  ChatView.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/21.
//

import SwiftUI
import MultipeerConnectivity

struct ChatView: View {
    @EnvironmentObject var mc: MCManager
    
    var body: some View {
        NavigationView {
            List {
                ForEach(mc.connectedPeers, id: \.self) { peerID in
                    let profile = mc.profiles[peerID] ?? Profile(name: peerID.displayName)
                    NavigationLink {
                        ChatDetail(peerID: peerID)
                            .environmentObject(mc)
                            .navigationTitle(profile.name)
                            .toolbar {
                                ToolbarItem(placement: .topBarTrailing) {
                                    NavigationLink {
                                        ChatProfile(peerID: peerID, profile: profile)
                                            .environmentObject(mc)
                                    } label: {
                                        Image(systemName: "info.circle")
                                    }
                                }
                            }
                            .toolbar(.hidden, for: .tabBar)
                    } label: {
                        ChatRow(profile: profile)
                    }
                }
                .onDelete(perform: { indexSet in
                    var peers: [MCPeerID] = []
                    for i in indexSet {
                        peers.append(mc.connectedPeers[i])
                    }
                    for peer in peers {
                        mc.session.cancelConnectPeer(peer)
                    }
                })
            }
            .listStyle(.inset)
            .navigationTitle("Connected Peers")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                EditButton()
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
            .environmentObject(MCManager())
    }
}
