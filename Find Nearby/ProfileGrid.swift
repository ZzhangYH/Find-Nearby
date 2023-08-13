//
//  ProfileGrid.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/1.
//

import SwiftUI

struct ProfileGrid: View {
    @State private var showCircle = false
    @State private var isLoading = false
    
    var profile: Profile
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(UIColor.systemGray5))
                .frame(width: 140, height: 180)
                .cornerRadius(20)
            
            VStack(alignment: .center) {
                ZStack {
                    if showCircle {
                        Circle()
                            .rotation(.degrees(-85))
                            .trim(from: 0.0, to: 0.975)
                            .stroke(Color(UIColor.systemBlue),
                                    style: StrokeStyle(lineWidth: 2, lineCap: .round))
                            .opacity(0.8)
                            .rotationEffect(.degrees(isLoading ? 360 : 0))
                    }
                    
                    profile.avatar
                        .resizable()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .onTapGesture {
                            showCircle.toggle()
                            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
                                isLoading.toggle()
                            }
                        }
                }
                .frame(width: 85, height: 85)
                
                Text(profile.name)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(width: 105, height: 45)
            }
        }
    }
}

struct ProfileGrid_Previews: PreviewProvider {
    static var previews: some View {
        ProfileGrid(profile: testProfiles[1])
    }
}
