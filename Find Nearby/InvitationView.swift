//
//  InvitationView.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/12.
//

import SwiftUI

struct InvitationView: View {
    @EnvironmentObject var mc: MCManager
    
    var name: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Rectangle()
                    .fill(Color(UIColor.systemGray4))
                    .ignoresSafeArea(edges: .top)
                    .frame(height: geometry.size.height * 0.25)
            
                Image("Test")
                    .resizable()
                    .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.45)
                    .clipShape(Circle())
                    .offset(y: -geometry.size.width * 0.3)
                    .padding(.bottom, -geometry.size.width * 0.3)
                
                Text(name)
                    .bold()
                    .font(.title)
                    .padding(10)
                
                Text("wants to start a session with you.")
                
                HStack(spacing: geometry.size.width * 0.05) {
                    InvitationButton(control: true)
                        .scaleEffect(geometry.size.width / 393)
                        .onTapGesture {
                            
                        }
                    
                    InvitationButton(control: false)
                        .scaleEffect(geometry.size.width / 393)
                        .onTapGesture {
                            
                        }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct InvitationView_Previews: PreviewProvider {
    static var previews: some View {
        InvitationView(name: "Test")
            .environmentObject(MCManager())
    }
}
