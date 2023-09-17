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
                Image(uiImage: UIImage(data: profile.avatar)!)
                    .resizable()
                    .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.45)
                    .clipShape(Circle())
                    .offset(y: geometry.size.width * 0.2)
                    .padding(.bottom, geometry.size.width * 0.2)

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
                            .foregroundColor(.accentColor)
                    }
                    .padding(.vertical, geometry.size.height * 0.005)
                    
                    VStack(alignment: .leading) {
                        Text("Allow others to find you?")
                            .font(.caption)
                        Text(profile.isAdvertising ? "Yes" : "No")
                            .font(.callout)
                            .foregroundColor(.accentColor)
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
