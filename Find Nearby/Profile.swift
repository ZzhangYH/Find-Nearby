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

var testProfiles = [
    Profile(name: "Yuhan Zhang", imageName: "Avatar", email: "yuhan.zhang7@outlook.com"),
    Profile(name: "John Appleseed", imageName: "Test", email: "test@apple.com"),
    Profile(name: "Vivian Chou", imageName: "Test", email: "test@apple.com"),
    Profile(name: "Rich Dinh", imageName: "Test", email: "test@apple.com"),
    Profile(name: "Guillermo", imageName: "Test", email: "test@apple.com"),
]
