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
                    NavigationLink {
                        ChatDetail(peerID: peerID)
                            .environmentObject(mc)
                            .navigationTitle(peerID.displayName)
                            .toolbar {
                                ToolbarItem(placement: .topBarTrailing) {
                                    NavigationLink {
                                        ChatProfile(peerID: peerID)
                                            .environmentObject(mc)
                                    } label: {
                                        Image(systemName: "info.circle")
                                    }
                                }
                            }
                    } label: {
                        ChatRow(peerID: peerID)
                            .environmentObject(mc)
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
