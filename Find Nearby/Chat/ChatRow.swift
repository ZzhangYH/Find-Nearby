//
//  ChatRow.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/9/15.
//

import SwiftUI

struct ChatRow: View {
    var profile: Profile
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(data: profile.avatar)!)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            Text(profile.name)
            
            Spacer()
        }
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(profile: Profile.default)
    }
}
