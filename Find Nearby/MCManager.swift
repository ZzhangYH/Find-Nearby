//
//  MCManager.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/7.
//

import Foundation
import MultipeerConnectivity
import SwiftUI

class MCManager: NSObject, ObservableObject {

    let defaults = UserDefaults.standard
    
    let serviceType = "find-nearby"
    var profile: Profile
    var peerID: MCPeerID
    var session: MCSession
    var serviceAdvertiser: MCNearbyServiceAdvertiser
    var serviceBrowser: MCNearbyServiceBrowser
    
    @Published var foundPeers: [MCPeerID] = []
    @Published var connectedPeers: [MCPeerID] = []
    @Published var messages: [MCPeerID : String] = [:]
    @Published var images: [MCPeerID : UIImage] = [:]
    @Published var profiles: [MCPeerID : Profile] = [:]
    
    override init() {
        profile = Profile.default
        peerID = MCPeerID(displayName: defaults.string(forKey: "Name") ?? UIDevice.current.name)
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        serviceBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        
        super.init()
        loadMC()
    }
    
    deinit {
        serviceAdvertiser.stopAdvertisingPeer()
        serviceBrowser.stopBrowsingForPeers()
    }
    
    func loadMC() {
        serviceAdvertiser.stopAdvertisingPeer()
        serviceBrowser.stopBrowsingForPeers()
        
        foundPeers.removeAll()
        connectedPeers.removeAll()
        
        profile = readFromDefaults()
        peerID = MCPeerID(displayName: profile.name)
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        serviceBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        
        session.delegate = self
        serviceAdvertiser.delegate = self
        serviceBrowser.delegate = self
        
        if profile.isAdvertising {
            serviceAdvertiser.startAdvertisingPeer()
        }
    }
    
    var isBrowsing = false {
        didSet {
            if isBrowsing {
                serviceBrowser.startBrowsingForPeers()
            } else {
                serviceBrowser.stopBrowsingForPeers()
            }
        }
    }
    
    func saveToDefaults(profile: Profile) {
        self.profile = profile
        defaults.set(profile.name, forKey: "Name")
        defaults.set(profile.avatar, forKey: "Avatar")
        defaults.set(profile.email, forKey: "Email")
        defaults.set(profile.isAdvertising, forKey: "isAdvertising")
        loadMC()
    }
    
    func readFromDefaults() -> Profile {
        return Profile(name: defaults.string(forKey: "Name") ?? "Default",
                       avatar: defaults.data(forKey: "Avatar") ?? UIImage(named: "Test")!.pngData()!,
                       email: defaults.string(forKey: "Email") ?? "default@multipeer.com",
                       isAdvertising: defaults.bool(forKey: "isAdvertising"))
    }

}

extension MCManager: MCSessionDelegate {

    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
            case .connected:
                print("Connected: \(peerID.displayName)")
            case .connecting:
                print("Connecting: \(peerID.displayName)")
            case .notConnected:
                print("Not connected: \(peerID.displayName)")
            @unknown default:
                print("Unknown state received: \(peerID.displayName)")
        }
        
        DispatchQueue.main.async {
            self.connectedPeers = session.connectedPeers
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let message = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async {
                self.messages[peerID] = message
            }
        }
        if let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.images[peerID] = image
            }
        }
        if let profile = try? JSONDecoder().decode(Profile.self, from: data) {
            DispatchQueue.main.async {
                self.profiles[peerID] = profile
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("Start receiving \"\(resourceName)\" from \(peerID.displayName)")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print("Finish receiving \"\(resourceName)\" from \(peerID.displayName)")
        
    }

}

extension MCManager: MCNearbyServiceAdvertiserDelegate {

    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = windowScene.windows.first
        else { return }
        let title = "\(peerID.displayName)"
        let message = "Would you like to accept the invitation?"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            invitationHandler(true, self.session)
        })
        window.rootViewController?.present(alertController, animated: true)
    }

}

extension MCManager: MCNearbyServiceBrowserDelegate {

    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        if !foundPeers.contains(peerID) {
            foundPeers.append(peerID)
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        if foundPeers.contains(peerID) {
            guard let index = foundPeers.firstIndex(of: peerID) else { return }
            foundPeers.remove(at: index)
        }
    }

}

//extension UIImage {
//    var base64: String {
//        self.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
//    }
//}
//
//extension String {
//    var imageFromBase64: UIImage {
//        let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters)
//        return UIImage(data: imageData!)!
//    }
//}
