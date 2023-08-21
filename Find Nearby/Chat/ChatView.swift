//
//  ChatView.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/21.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var mc: MCManager
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(mc.connectedPeers, id: \.self) { peerID in
                        NavigationLink {
                            ChatDetail(peerID: peerID)
                                .environmentObject(mc)
                        } label: {
                            Text(peerID.displayName)
                        }
                    }
                } header: {
                    Text("\(Image(systemName: "person.crop.circle.badge.checkmark").renderingMode(.original)) ")
                        .foregroundColor(Color(UIColor.systemBlue)) +
                    Text("Connected Peers")
                }
            }
            .navigationTitle("Find Nearby")
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
