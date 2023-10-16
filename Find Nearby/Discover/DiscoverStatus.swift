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
            .scrollContentBackground(.hidden)
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct DiscoverStatusSection: View {
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
