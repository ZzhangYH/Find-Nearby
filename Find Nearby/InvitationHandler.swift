//
//  InvitationHandler.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/13.
//

import SwiftUI

struct InvitationHandler: View {
    @Binding var isShowSheet: Bool
    
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

//struct InvitationHandler_Previews: PreviewProvider {
//    static var previews: some View {
//        InvitationHandler()
//    }
//}
