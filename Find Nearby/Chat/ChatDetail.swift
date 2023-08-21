//
//  ChatDetail.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/21.
//

import SwiftUI
import MultipeerConnectivity

struct ChatDetail: View {
    @EnvironmentObject var mc: MCManager
    
    var peerID: MCPeerID
    @State private var message = ""
    
    var body: some View {
        VStack {
            Text(peerID.displayName)
                .font(.title).bold()
            
            Spacer()
            
            Text(mc.message)
            
            Spacer()
            
            TextField("Text message", text: $message)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.send)
                .onSubmit {
                    send(message: $message)
                }
        }
        .padding()
    }
    
    func send(message: Binding<String>) {
        if mc.connectedPeers.contains(peerID) {
            do {
                try mc.session.send($message.wrappedValue.data(using: .utf8)!, toPeers: [peerID], with: .reliable)
            } catch {
                print("Error occurred when sending \($message.wrappedValue.data(using: .utf8)!)")
            }
        }
    }
}
