//
//  InvitationHandler.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/13.
//

import SwiftUI

struct InvitationHandler: View {
    @EnvironmentObject var mc: MCManager
    
    @Binding var isShowSheet: Bool
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    InvitationView(name: "Test")
                        .environmentObject(mc)
                } label: {
                    Text("test")
                }
            }
            .navigationTitle("All Invitations")
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
