//
//  InvitationHandler.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/13.
//

import SwiftUI
import MultipeerConnectivity

struct InvitationList: View {
    @EnvironmentObject var mc: MCManager
    
    @Binding var isShowSheet: Bool
    
    var body: some View {
        NavigationView {
            Group {
                if !mc.connectedPeers.isEmpty {
                    List(mc.connectedPeers, id: \.self) { peerID in
                        NavigationLink {
                            InvitationView(peerID: peerID)
                                .environmentObject(mc)
                        } label: {
                            Text(peerID.displayName)
                        }
                    }
                } else {
                    ZStack {
                        Color(UIColor.systemGroupedBackground)
                            .ignoresSafeArea()
                        
                        VStack {
                            Spacer()
                            
                            Text("No invitations")
                                .font(.title)
                                .padding()
                            
                            Spacer()
                            
                            VStack {
                                if mc.profile.allowOthersToFindYou {
                                    Text("Still searching...")
                                } else {
                                    Text("You are not discovered by others")
                                    
                                    Text("Change discovery preference in ") +
                                    Text("\(Image(systemName: "person.circle.fill")) Profile \(Image(systemName: "chevron.right")) Edit")
                                        .foregroundColor(Color(UIColor.systemBlue))
                                }
                            }
                            .font(.footnote)
                            .padding()
                        }
                        .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Invitations")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    isShowSheet = false
                } label: {
                    Text("Close")
                }
            }
        }
    }
}
