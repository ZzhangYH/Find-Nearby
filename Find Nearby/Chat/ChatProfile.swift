//
//  ChatProfile.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/9/15.
//

import SwiftUI
import MultipeerConnectivity

struct ChatProfile: View {
    @EnvironmentObject var mc: MCManager
    @State var showActionSheet = false
    
    var peerID: MCPeerID
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                if mc.profiles[peerID] != nil {
                    Image(uiImage: UIImage(data: mc.profiles[peerID]!.avatar)!)
                        .resizable()
                        .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.45)
                        .clipShape(Circle())
                        .offset(y: geometry.size.width * 0.1)
                        .padding(.bottom, geometry.size.width * 0.1)
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .foregroundColor(.secondary)
                        .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.45)
                        .clipShape(Circle())
                        .offset(y: geometry.size.width * 0.1)
                        .padding(.bottom, geometry.size.width * 0.1)
                }

                Text(peerID.displayName)
                    .font(.title).bold()
                    .padding(geometry.size.height * 0.01)

                List {
                    ProfileRow(name: "Email address", element: mc.profiles[peerID]?.email ?? "N/A")
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(role: .destructive) {
                    showActionSheet = true
                } label: {
                    Text("Disconnect Peer")
                }
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("Disconnect the chat session with \(peerID.displayName)?"),
                                buttons: [
                                    .destructive(Text("Disconnect")) {
                                        mc.session.cancelConnectPeer(peerID)
                                    },
                                    .cancel()
                                ])
                }
                .padding()
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct ChatProfile_Previews: PreviewProvider {
    static var previews: some View {
        ChatProfile(peerID: MCPeerID(displayName: "Test"))
            .environmentObject(MCManager())
    }
}
