//
//  Profile.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/1.
//

import Foundation
import SwiftUI

struct Profile: Equatable {
    var name: String
    var imageName = "Test"
    var avatar: Image {
        Image(imageName)
    }
    var email = "default@multipeer.com"
    var allowOthersToFindYou = false
    
    static let `default` = Profile(name: "Default")
    
    func equals(profile: Profile) -> Bool {
        if self.name != profile.name { return false }
        if self.email != profile.email { return false }
        if self.allowOthersToFindYou != profile.allowOthersToFindYou { return false }
        return true
    }
}


