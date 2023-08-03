//
//  ProfileView.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/1.
//

import SwiftUI

struct ProfileView: View {
    var profile: Profile
    @State private var testToggle: Bool = false

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
                    .padding(10)

                ZStack {
                    Rectangle()
                        .fill(Color(UIColor.systemGray6))
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.08)
                        .cornerRadius(10)

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Email address")
                                .font(.caption)
                            Text(profile.email)
                                .bold()
                                .foregroundColor(Color(UIColor.systemBlue))
                        }
                        .font(.subheadline)

                        Spacer()
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.9)
                }

                ZStack {
                    Rectangle()
                        .fill(Color(UIColor.systemGray6))
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.08)
                        .cornerRadius(10)

                    Toggle(isOn: $testToggle) {
                        Text("Allow others to find you?")
                            .bold()
                            .font(.subheadline)
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.9)
                }

                Spacer()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profile: testProfiles[0])
    }
}
