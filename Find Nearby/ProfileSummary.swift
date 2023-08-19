//
//  ProfileView.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/1.
//

import SwiftUI

struct ProfileSummary: View {
    var profile: Profile

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Rectangle()
                    .fill(Color(UIColor.systemGray4))
                    .ignoresSafeArea(edges: .top)
                    .frame(height: geometry.size.height * 0.3)

                profile.avatar
                    .resizable()
                    .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.45)
                    .clipShape(Circle())
                    .offset(y: -geometry.size.width * 0.3)
                    .padding(.bottom, -geometry.size.width * 0.3)

                Text(profile.name)
                    .bold()
                    .font(.title)
                    .padding(geometry.size.height * 0.01)

                List {
                    VStack(alignment: .leading) {
                        Text("Email address")
                            .font(.caption)
                        Text(profile.email)
                            .font(.callout)
                            .foregroundColor(Color(UIColor.systemBlue))
                    }
                    .padding(.vertical, geometry.size.height * 0.005)
                    
                    VStack(alignment: .leading) {
                        Text("Allow others to find you?")
                            .font(.caption)
                        Text(profile.allowOthersToFindYou ? "Yes" : "No")
                            .font(.callout)
                            .foregroundColor(Color(UIColor.systemBlue))
                    }
                    .padding(.vertical, geometry.size.height * 0.005)
                }
                .padding(.horizontal)
                .listStyle(.plain)
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
    }
}