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
    var profile: Profile
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Image(uiImage: UIImage(data: profile.avatar)!)
                    .resizable()
                    .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.45)
                    .clipShape(Circle())
                    .offset(y: geometry.size.width * 0.1)
                    .padding(.bottom, geometry.size.width * 0.1)

                Text(profile.name)
                    .bold()
                    .font(.title)
                    .padding(geometry.size.height * 0.01)

                List {
                    VStack(alignment: .leading) {
                        Text("Email address")
                            .font(.caption)
                        Text(profile.email)
                            .font(.callout)
                            .foregroundColor(.accentColor)
                    }
                    .padding(.vertical, geometry.size.height * 0.005)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(role: .destructive) {
                    showActionSheet = true
                } label: {
                    Text("Disconnect Peer")
                }
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("Disconnect the chat session with \(profile.name)?"),
                                buttons: [
                                    .destructive(Text("Disconnect")) {
                                        mc.session.cancelConnectPeer(peerID)
                                    },
                                    .cancel()
                                ])
                }
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct ChatProfile_Previews: PreviewProvider {
    static var previews: some View {
        ChatProfile(peerID: MCPeerID(displayName: "Test"), profile: Profile(name: "Test"))
            .environmentObject(MCManager())
    }
}
