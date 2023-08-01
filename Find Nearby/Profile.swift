//
//  Profile.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/1.
//

import Foundation
import SwiftUI

struct Profile {
    var name: String
    var imageName: String
    var avatar: Image {
        Image(imageName)
    }
    var email: String
}

var testProfiles = [Profile(name: "Yuhan Zhang", imageName: "Avatar", email: "yuhan.zhang7@outlook.com"), Profile(name: "Test", imageName: "Test", email: "test@apple.com")]
