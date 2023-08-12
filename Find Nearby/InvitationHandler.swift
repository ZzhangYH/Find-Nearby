//
//  InvitationHandler.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/13.
//

import SwiftUI

struct InvitationHandler: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    InvitationView(name: "test")
                } label: {
                    Text("test")
                }
            }
            .navigationTitle("All Invitations")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct InvitationHandler_Previews: PreviewProvider {
    static var previews: some View {
        InvitationHandler()
    }
}
