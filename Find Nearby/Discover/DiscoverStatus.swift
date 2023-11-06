//
//  DiscoverStatus.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/10/16.
//

import SwiftUI
import MultipeerConnectivity

struct DiscoverStatus: View {
    @EnvironmentObject var mc: MCManager
    
    var body: some View {
        if mc.connectedPeers.isEmpty && mc.notConnectedPeers.isEmpty {
            Text("Waiting for invitation...")
                .font(.callout)
                .foregroundColor(.secondary)
        } else {
            List {
                DiscoverStatusSection(data: mc.connectedPeers, isConnected: true)
                DiscoverStatusSection(data: mc.notConnectedPeers, isConnected: false)
            }
            .environmentObject(mc)
            .scrollContentBackground(.hidden)
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct DiscoverStatusSection: View {
    @EnvironmentObject var mc: MCManager
    
    var data: [MCPeerID]
    var isConnected: Bool
    
    var body: some View {
        Section {
            ForEach(data, id: \.self) { peerID in
                HStack {
                    let symbol = isConnected ? "checkmark.circle.fill" : "exclamationmark.circle.fill"
                    let color = isConnected ? Color(UIColor.systemGreen) : Color(UIColor.systemRed)
                    
                    Image(systemName: symbol)
                        .foregroundColor(color)
                        .imageScale(.small)
                    Text(peerID.displayName)
                    
                    Spacer()
                    
                    if !isConnected {
                        Button("Reconnect", systemImage: "bolt.horizontal.circle.fill") {
                            mc.serviceBrowser.invitePeer(peerID, to: mc.session, withContext: nil, timeout: 60)
                        }
                        .foregroundColor(.secondary)
                        .labelStyle(.iconOnly)
                    }
                }
            }
            .listRowBackground(Color(UIColor.quaternarySystemFill))
        } header: {
            Text(isConnected ? "Connected" : "Not connected")
        }
    }
}

struct DiscoverStatus_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverStatus()
            .environmentObject(MCManager())
    }
}
