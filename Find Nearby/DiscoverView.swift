//
//  DiscoverView.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/2.
//

import SwiftUI

struct DiscoverView: View {
    @StateObject var mc = MCConnection()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                let numOfHS = Int(ceil(Double(testProfiles.count) / 2))

                ForEach(0...numOfHS, id: \.self) { num in
                    let index = num * 2

                    HStack {
                        Spacer()

                        if index < testProfiles.count {
                            ProfileGrid(profile: testProfiles[index])
                                .scaleEffect(geometry.size.width / 393)
                                .padding(.horizontal, geometry.size.width * 0.01)
                        }
                        if index + 1 < testProfiles.count {
                            ProfileGrid(profile: testProfiles[index + 1])
                                .scaleEffect(geometry.size.width / 393)
                                .padding(.horizontal, geometry.size.width * 0.01)
                        }

                        Spacer()
                    }
                    .padding(.vertical, geometry.size.height * 0.01)
                }
                
                VStack(alignment: .center) {
                    ForEach(mc.connectedPeers, id: \.displayName) { peer in
                        Text(peer.displayName)
                    }
                }
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
