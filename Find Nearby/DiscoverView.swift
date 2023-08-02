//
//  DiscoverView.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/2.
//

import SwiftUI

struct DiscoverView: View {
    var body: some View {
        ScrollView {
            let numOfHS = Int(ceil(Double(testProfiles.count) / 2))
            
            ForEach(0...numOfHS, id: \.self) { num in
                let index = num * 2
                HStack {
                    if index < testProfiles.count {
                        ProfileGrid(profile: testProfiles[index])
                    }
                    if index + 1 < testProfiles.count {
                        ProfileGrid(profile: testProfiles[index + 1])
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
