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
            VStack {
                if mc.connectedPeers.isEmpty {
                    EmptyChatNotice()
                } else {
                    ChatList()
                        .environmentObject(mc)
                }
            }
            .navigationTitle("Chat Sessions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if !mc.connectedPeers.isEmpty {
                    EditButton()
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct EmptyChatNotice: View {
    var body: some View {
        VStack {
            Image(systemName: "person.fill.questionmark")
                .font(.system(size: 80))
                .foregroundColor(.accentColor)
            Text("No active chats")
                .font(.largeTitle).bold()
                .padding(.leastNormalMagnitude)
        }
        .padding()
        
        VStack(alignment: .listRowSeparatorLeading, spacing: 10) {
            Text("Go to ") +
            Text("\(Image(systemName: "wifi.circle"))Discover ").foregroundColor(.accentColor) +
            Text("page and invite nearby peers to your chat session!")
            
            Text("Or you can check your settings and see if you are allowing others to find you under ") +
            Text("\(Image(systemName: "person.circle"))Profile ").foregroundColor(.accentColor) +
            Text("page for nearby peers to send invitations.")
        }
        .font(.caption)
        .padding(.horizontal, 36)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
            .environmentObject(MCManager())
    }
}
