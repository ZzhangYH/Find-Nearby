//
//  ChatDetail.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/21.
//

import SwiftUI
import PhotosUI
import MultipeerConnectivity

struct ChatDetail: View {
    @EnvironmentObject var mc: MCManager
    
    @State private var showActionSheet = false
    @State private var showPhotosPicker = false
    @State private var showFileImporter = false
    @State private var message = ""
    @State private var photoItem: PhotosPickerItem? = nil
    
    var peerID: MCPeerID
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: mc.profiles[peerID]?.avatar ?? Profile.default.avatar)!)
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .padding(.bottom, 5)
            
            Text(peerID.displayName)
                .font(.callout)
            
            Spacer()
            
            Text(mc.messages[peerID] ?? "")
            
            Image(uiImage: mc.images[peerID] ?? UIImage())
                .resizable()
                .scaledToFit()
                .padding()
            
            Spacer()
            
            HStack {
                Button {
                    showActionSheet = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title2)
                }
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("Choose photo or file from"),
                                buttons: [
                                    .default(Text("Photo Library")) {
                                        showPhotosPicker = true
                                    },
                                    .default(Text("Files")) {
                                        showFileImporter = true
                                    },
                                    .cancel()
                                ])
                }
                
                TextField("Text message", text: $message)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.send)
                    .onSubmit {
                        send(data: $message.wrappedValue.data(using: .utf8)!)
                        message = ""
                    }
            }
        }
        .photosPicker(isPresented: $showPhotosPicker, selection: $photoItem)
        .onChange(of: photoItem) { _ in
            Task {
                if let photo = try? await photoItem?.loadTransferable(type: Data.self) {
                    send(data: photo)
                }
            }
        }
        .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.item], allowsMultipleSelection: false, onCompletion: { (result) in
            do {
                let fileURL = try result.get()
                send(fileURL: fileURL.first!)
            } catch {
                print("Error occurred when reading file")
            }
        })
        .padding()
    }
    
    func send(data: Data) {
        if mc.connectedPeers.contains(peerID) {
            do {
                try mc.session.send(data, toPeers: [peerID], with: .reliable)
            } catch {
                print("Error occurred when sending \"\($message.wrappedValue)\"")
            }
        }
    }
    
    func send(fileURL: URL) {
        if mc.connectedPeers.contains(peerID) {
            mc.session.sendResource(at: fileURL, withName: fileURL.lastPathComponent, toPeer: peerID)
            send(data: fileURL.lastPathComponent.data(using: .utf8)!)
        }
    }
}

struct ChatDetail_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetail(peerID: MCPeerID(displayName: "Test"))
            .environmentObject(MCManager())
    }
}