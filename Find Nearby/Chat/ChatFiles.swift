//
//  ChatFiles.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/10/25.
//

import SwiftUI

struct ChatFiles: View {
    @State private var fileURL: URL?
    
    var body: some View {
        List {
            ForEach(getFiles(), id: \.self) { file in
                Button(file.lastPathComponent) {
                    fileURL = file
                }
                .quickLookPreview($fileURL)
            }
        }
    }
    
    func getFiles() -> [URL] {
        do {
            let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let files = try FileManager.default.contentsOfDirectory(at: documentURL!, includingPropertiesForKeys: nil)
            return files
        } catch {
            return []
        }
    }
}

struct ChatFiles_Previews: PreviewProvider {
    static var previews: some View {
        ChatFiles()
    }
}
