//
//  ProfileHost.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/15.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var mc: MCManager
    
    @State var editMode: EditMode = .inactive
    @State private var draftProfile = Profile.default
    
    var body: some View {
        ZStack {
            if editMode == .inactive {
                ProfileSummary(profile: mc.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        draftProfile = mc.profile
                    }
                    .onDisappear {
                        if draftProfile != mc.profile {
                            mc.saveToDefaults(profile: draftProfile)
                        }
                    }
            }
            
            VStack {
                HStack {
                    if editMode == .active {
                        Button("Cancel", role: .cancel) {
                            draftProfile = mc.profile
                            withAnimation {
                                editMode = .inactive
                            }
                        }
                    }
                    Spacer()
                    
                    EditButton()
                }
                .environment(\.editMode, $editMode)
                .padding()
                
                Spacer()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(MCManager())
    }
}
