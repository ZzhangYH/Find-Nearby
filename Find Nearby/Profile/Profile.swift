//
//  Profile.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/1.
//

import Foundation
import SwiftUI

struct Profile: Codable, Equatable {
    var name = "Default"
    var avatar = UIImage(named: "Test")!.pngData()!
    var email = "default@multipeer.com"
    var isAdvertising = false
    
    static let `default` = Profile()
    
    func data() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    func equals(profile: Profile) -> Bool {
        if self.name != profile.name { return false }
        if self.avatar != profile.avatar { return false }
        if self.email != profile.email { return false }
        if self.isAdvertising != profile.isAdvertising { return false }
        return true
    }
}
