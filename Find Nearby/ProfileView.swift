//
//  ProfileView.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/1.
//

import SwiftUI

struct ProfileView: View {
    var profile: Profile

    var body: some View {
        VStack {
            Rectangle()
                .fill(Color(UIColor.systemGray4))
                .ignoresSafeArea(edges: .top)
                .frame(height: 265)
            
            profile.avatar
                .resizable()
                .frame(width: 175, height: 175)
                .clipShape(Circle())
                .offset(y: -130)
                .padding(.bottom, -130)
            
            Text(profile.name)
                .font(.title)
                .padding(10)
            
            ZStack {
                Rectangle()
                    .fill(Color(UIColor.systemGray6))
                    .frame(width: 365, height: 60)
                    .cornerRadius(10)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Email address")
                        Text(profile.email)
                            .bold()
                    }
                    .font(.subheadline)
                    .padding(.horizontal, 30)
                    
                    Spacer()
                }
            }
            
            ZStack {
                Rectangle()
                    .fill(Color(UIColor.systemGray6))
                    .frame(width: 365, height: 60)
                    .cornerRadius(10)
                
                
            }
            
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profile: testProfiles[0])
    }
}
