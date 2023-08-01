//
//  ProfileGrid.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/1.
//

import SwiftUI

struct ProfileGrid: View {
    var profile: Profile
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(UIColor.systemGray5))
                .frame(width: 140, height: 180)
                .cornerRadius(20)
            
            VStack(alignment: .center) {
                profile.avatar
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                
                Text(profile.name)
                    .frame(width: 105)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding()
            }
        }
    }
}

struct ProfileGrid_Previews: PreviewProvider {
    static var previews: some View {
        ProfileGrid(profile: testProfiles[1])
    }
}
