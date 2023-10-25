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
    @State private var fileURL: URL?
    
    var peerID: MCPeerID
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(mc.messages[peerID] ?? "")
            if mc.mStatus[peerID] != nil {
                ChatElementStatus(status: mc.mStatus[peerID]!)
            }
            
            Spacer()
            
            Image(uiImage: mc.images[peerID] ?? UIImage())
                .resizable()
                .scaledToFit()
                .padding()
                .contextMenu {
                    Button {
                        UIPasteboard.general.image = mc.images[peerID]
                    } label: {
                        Label("Copy", systemImage: "doc.on.doc")
                    }
                    let image = Image(uiImage: mc.images[peerID] ?? UIImage())
                    ShareLink(item: image,
                              preview: SharePreview("Chat Image Selected", image: image)) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                }
            if mc.iStatus[peerID] != nil {
                ChatElementStatus(status: mc.iStatus[peerID]!)
            }
            
            Spacer()
            
            if mc.files[peerID] != nil {
                Button {
                    fileURL = mc.files[peerID]
                } label: {
                    Text(mc.files[peerID]!.lastPathComponent)
                }
                .quickLookPreview($fileURL)
            }
            if mc.fStatus[peerID] != nil {
                ChatElementStatus(status: mc.fStatus[peerID]!)
            }
            
            Spacer()
            
            ChatInputController(peerID: peerID)
                .environmentObject(mc)
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .padding()
    }
}

struct ChatElementStatus: View {
    var status: Bool
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(status ? "Received" : "Sent")
                .foregroundColor(Color(status ? UIColor.systemBlue : UIColor.systemGreen))
                .font(.caption)
                .padding(.horizontal)
        }
    }
}

struct ChatInputController: View {
    @EnvironmentObject var mc: MCManager
    @State private var showActionSheet = false
    @State private var showPhotosPicker = false
    @State private var showFileImporter = false
    @State private var message = ""
    @State private var photoItem: PhotosPickerItem? = nil
    
    var peerID: MCPeerID
    
    var body: some View {
        HStack {
            Button {
                showActionSheet = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.secondary)
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
                    mc.send($message.wrappedValue.data(using: .utf8)!, with: .message, toPeer: peerID)
                    mc.messages[peerID] = message
                    mc.mStatus[peerID] = false
                    message = ""
                }
        }
        .photosPicker(isPresented: $showPhotosPicker, selection: $photoItem)
        .onChange(of: photoItem) { _ in
            Task {
                if let photo = try? await photoItem?.loadTransferable(type: Data.self) {
                    mc.send(photo, with: .image, toPeer: peerID)
                    mc.images[peerID] = UIImage(data: photo)
                    mc.iStatus[peerID] = false
                }
            }
        }
        .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.item]) { result in
            do {
                let fileURL = try result.get()
                if fileURL.startAccessingSecurityScopedResource() == true {
                    mc.sendResource(at: fileURL, toPeer: peerID)
                    mc.files[peerID] = fileURL
                    mc.fStatus[peerID] = false
                }
            } catch {
                print("Error occurred when reading file")
            }
        }
    }
}

struct ChatDetail_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetail(peerID: MCPeerID(displayName: "Test"))
            .environmentObject(MCManager())
    }
}
