//
//  MCManager.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/7.
//

import Foundation
import MultipeerConnectivity

class MCManager: NSObject, ObservableObject {
    
    private var serviceType = "find-nearby"
    private var peerID: MCPeerID
    @Published var session: MCSession
    @Published var serviceAdvertiser: MCNearbyServiceAdvertiser
    @Published var serviceBrowser: MCNearbyServiceBrowser
    
    @Published var foundPeers: [MCPeerID] = []
    @Published var isAcceptingInvitation = false
    
    override init() {
        peerID = MCPeerID(displayName: "test")
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        serviceBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        
        super.init()
        
        session.delegate = self
        serviceAdvertiser.delegate = self
        serviceBrowser.delegate = self
        
        serviceAdvertiser.startAdvertisingPeer()
        serviceBrowser.startBrowsingForPeers()
    }
    
    deinit {
        serviceAdvertiser.stopAdvertisingPeer()
        serviceBrowser.stopBrowsingForPeers()
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
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }

}

extension MCManager: MCNearbyServiceAdvertiserDelegate {

    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(isAcceptingInvitation, session)
    }

}

extension MCManager: MCNearbyServiceBrowserDelegate {

    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        foundPeers.append(peerID)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        foundPeers.remove(at: foundPeers.firstIndex(of: peerID)!)
    }

}
