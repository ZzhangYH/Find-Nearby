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
    
    init(name: String, imageName: String, email: String) {
        self.name = name
        self.imageName = imageName
        self.email = email
    }
    
    init(name: String) {
        self.name = name
        self.imageName = "Test"
        self.email = "test@multipeer.com"
    }
}

var testProfiles = [
    Profile(name: "Yuhan Zhang", imageName: "Avatar", email: "yuhan.zhang7@outlook.com"),
    Profile(name: "John Appleseed"),
    Profile(name: "Vivian Chou"),
    Profile(name: "Rich Dinh"),
    Profile(name: "Guillermo")
]
