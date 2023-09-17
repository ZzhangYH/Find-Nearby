//
//  ChatRow.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/9/15.
//

import SwiftUI
import MultipeerConnectivity

struct ChatRow: View {
    @EnvironmentObject var mc: MCManager
    
    var peerID: MCPeerID
    
    var body: some View {
        HStack {
            if mc.profiles[peerID] != nil {
                Image(uiImage: UIImage(data: mc.profiles[peerID]!.avatar)!)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .foregroundColor(.secondary)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
            
            Text(peerID.displayName)
            
            Spacer()
        }
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(peerID: MCPeerID(displayName: "Test"))
            .environmentObject(MCManager())
    }
}
