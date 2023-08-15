//
//  ProfileEditor.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/15.
//

import SwiftUI

struct ProfileEditor: View {
    @Binding var profile: Profile
    
    var body: some View {
        VStack {
            HStack {}
                .padding()
            
            List {
                VStack(alignment: .listRowSeparatorLeading) {
                    Text("Name").font(.subheadline).bold()
                    TextField("Name", text: $profile.name)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                VStack(alignment: .listRowSeparatorLeading) {
                    Text("Email address").font(.subheadline).bold()
                    TextField("Email address", text: $profile.email)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                Toggle(isOn: $profile.allowOthersToFindYou) {
                    Text("Allow others to find you?").font(.subheadline).bold()
                }
                .padding(.vertical)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default))
    }
}
