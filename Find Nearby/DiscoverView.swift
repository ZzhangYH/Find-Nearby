//
//  DiscoverView.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/2.
//

import SwiftUI

struct DiscoverView: View {
    @StateObject var mc = MCManager()
    @State private var showInvitations = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView {
                    let count = mc.foundPeers.count
                    let numOfHS = Int(ceil(Double(count) / 2))
                    
                    Spacer(minLength: geometry.size.height * 0.01)
                    
                    ForEach(0...numOfHS, id: \.self) { num in
                        let index = num * 2

                        HStack {
                            Spacer()

                            if index < count {
                                ProfileGrid(profile: Profile(name: mc.foundPeers[index].displayName))
                                    .scaleEffect(geometry.size.width / 393)
                                    .padding(.horizontal, geometry.size.width * 0.01)
                            }
                            if index + 1 < count {
                                ProfileGrid(profile: Profile(name: mc.foundPeers[index + 1].displayName))
                                    .scaleEffect(geometry.size.width / 393)
                                    .padding(.horizontal, geometry.size.width * 0.01)
                            }

                            Spacer()
                        }
                        .padding(.vertical, geometry.size.height * 0.01)
                    }
                }
                .navigationTitle("Find Nearby")
                .toolbar {
                    Button {
                        showInvitations.toggle()
                    } label: {
                        Label("Show all invitations", systemImage: "tray.and.arrow.down.fill")
                    }
                }
                .sheet(isPresented: $showInvitations) {
                    InvitationHandler()
                }
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
