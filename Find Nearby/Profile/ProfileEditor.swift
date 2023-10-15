//
//  ProfileEditor.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/15.
//

import SwiftUI
import PhotosUI

struct ProfileEditor: View {
    @Binding var profile: Profile
    @State private var avatarItem: PhotosPickerItem? = nil
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                HStack {}
                    .padding()
                
                Image(uiImage: UIImage(data: profile.avatar)!)
                    .resizable()
                    .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                    .clipShape(Circle())
                    .overlay(alignment: .bottomTrailing) {
                        PhotosPicker(selection: $avatarItem, matching: .images) {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title)
                                .foregroundColor(.accentColor)
                        }
                        .buttonStyle(.borderless)
                    }
                
                List {
                    ProfileEditorRow(name: "Name", element: $profile.name)
                    ProfileEditorRow(name: "Email address", element: $profile.email)
                    Toggle(isOn: $profile.isAdvertising) {
                        Text("Allow others to find you?").font(.subheadline).bold()
                    }
                    .padding(.vertical)
                }
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .onChange(of: avatarItem) { _ in
            Task {
                if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        profile.avatar = uiImage.pngData()!
                    }
                }
            }
        }
    }
}

struct ProfileEditorRow: View {
    var name: String
    @Binding var element: String
    
    var body: some View {
        VStack(alignment: .listRowSeparatorLeading) {
            Text(name).font(.subheadline).bold()
            TextField(name, text: $element)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default))
    }
}
