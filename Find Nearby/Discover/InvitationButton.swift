//
//  InvitationButton.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/12.
//

import SwiftUI

struct InvitationButton: View {
    @GestureState private var isPressed = false
    var control: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(UIColor.systemGray6))
                .frame(width: 133, height: 140)
                .cornerRadius(10)
            
            let symbol = control ? "checkmark" : "xmark"
            let label = control ? "Accept" : "Decline"
            let color = control ? Color(.systemGreen) : Color(.systemRed)
            
            VStack {
                Image(systemName: symbol)
                    .foregroundColor(color)
                    .font(.system(size: 54))
                    .frame(width: 54, height: 54)
                    .offset(y: -5)
                    .padding(5)
                
                Text(label)
                    .foregroundColor(color)
                    .font(.headline)
            }
        }
    }
}

struct InvitationButton_Previews: PreviewProvider {
    static var previews: some View {
        InvitationButton(control: true)
    }
}
