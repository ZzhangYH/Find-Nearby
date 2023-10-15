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
                    .font(.title).bold()
                    .padding(geometry.size.height * 0.01)

                List {
                    ProfileRow(name: "Email address", element: profile.email)
                    ProfileRow(name: "Allow others to find you?", element: profile.isAdvertising ? "Yes": "No")
                }
                .listStyle(.plain)
                .padding(.horizontal)
            }
        }
    }
}

struct ProfileRow: View {
    var name: String
    var element: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name).font(.caption)
            Text(element).font(.callout)
                .foregroundColor(.accentColor)
                .padding(.leastNormalMagnitude)
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
    }
}
