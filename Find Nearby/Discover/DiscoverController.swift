//
//  DiscoverController.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/10/15.
//

import SwiftUI

struct DiscoverController: View {
    @EnvironmentObject var mc: MCManager
    
    @State var isBrowsing: Bool
    
    var body: some View {
        let toggleBinding = Binding {
            mc.isBrowsing
        } set: {
            mc.isBrowsing = $0
            self.isBrowsing = $0
        }
        
        HStack {
            Text("Browsing nearby devices  ")
                .foregroundColor(.secondary)
            
            if isBrowsing && mc.profile.isAdvertising {
                ProgressView()
            }
            
            Spacer()
            
            Toggle("Browsing nearby devices", isOn: toggleBinding)
                .labelsHidden()
        }
        .padding(.horizontal)
    }
}

struct DiscoverController_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverController(isBrowsing: MCManager().isBrowsing)
            .environmentObject(MCManager())
    }
}
