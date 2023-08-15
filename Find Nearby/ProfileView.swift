//
//  ProfileHost.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/15.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var mc: MCManager
    
    @State private var isEditing = false
    @State private var draftProfile = Profile.default
    
    var body: some View {
        ZStack {
            if !isEditing {
                ProfileSummary(profile: mc.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        draftProfile = mc.profile
                    }
                    .onDisappear {
                        mc.profile = draftProfile
                    }
            }
            
            VStack {
                HStack {
                    if isEditing {
                        Button(action: {
                            draftProfile = mc.profile
                            withAnimation {
                                isEditing = false
                            }
                        }, label: {
                            Text("Cancel").foregroundColor(Color(UIColor.systemBlue))
                        })
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            isEditing.toggle()
                        }
                    }, label: {
                        if !isEditing {
                            Text("Edit").foregroundColor(Color(UIColor.systemBlue))
                        } else {
                            Text("Done").foregroundColor(Color(UIColor.systemBlue))
                        }
                    })
                }
                .environment(\.editMode, .constant(isEditing ? EditMode.active : EditMode.inactive))
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
