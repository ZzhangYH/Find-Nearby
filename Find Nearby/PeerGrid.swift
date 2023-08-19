//
//  PeerGrid.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/1.
//

import SwiftUI
import MultipeerConnectivity

struct PeerGrid: View {
    @EnvironmentObject var mc: MCManager
    
    @State private var showCircle = false
    @State private var isLoading = false
    
    var peerID: MCPeerID
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(UIColor.systemGray5))
                .frame(width: 140, height: 180)
                .cornerRadius(20)
            
            VStack(alignment: .center) {
                ZStack {
                    if showCircle {
                        Circle()
                            .rotation(.degrees(-85))
                            .trim(from: 0.0, to: 0.975)
                            .stroke(Color(UIColor.systemBlue),
                                    style: StrokeStyle(lineWidth: 2, lineCap: .round))
                            .opacity(0.8)
                            .rotationEffect(.degrees(isLoading ? 360 : 0))
                    }
                    
                    Image("Test")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .onTapGesture {
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            showCircle.toggle()
                            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
                                isLoading.toggle()
                            }
                            if isLoading {
                                mc.serviceBrowser.invitePeer(peerID, to: mc.session, withContext: nil, timeout: 60)
                            } else {
                                mc.session.cancelConnectPeer(peerID)
                            }
                        }
                }
                .frame(width: 85, height: 85)
                
                Text(peerID.displayName)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(width: 105, height: 45)
            }
        }
    }
}
