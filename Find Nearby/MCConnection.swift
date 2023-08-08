//
//  MCConnection.swift
//  Find Nearby
//
//  Created by Yuhan Zhang on 2023/8/7.
//

import Foundation
import MultipeerConnectivity

class MCConnection: NSObject, ObservableObject {

    @Published var connectedPeers: [MCPeerID] = []
    
    private var serviceType: String
    private var peerID: MCPeerID
    private var session: MCSession
    private var serviceAdvertiser: MCNearbyServiceAdvertiser
    private var serviceBrowser: MCNearbyServiceBrowser

    override init() {
        serviceType = "find-nearby"
        peerID = MCPeerID(displayName: UIDevice.current.name)
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        serviceBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        
        super.init()
        
        session.delegate = self
        
        serviceAdvertiser.delegate = self
        serviceAdvertiser.startAdvertisingPeer()
        
        serviceBrowser.delegate = self
        serviceBrowser.startBrowsingForPeers()
    }
    
    deinit {
        serviceAdvertiser.stopAdvertisingPeer()
        serviceBrowser.stopBrowsingForPeers()
    }

}

extension MCConnection: MCSessionDelegate {

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
        DispatchQueue.main.async {
            self.connectedPeers = session.connectedPeers
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }

}

extension MCConnection: MCNearbyServiceAdvertiserDelegate {

    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
    }

}

extension MCConnection: MCNearbyServiceBrowserDelegate {

    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print(peerID)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
    }

}
