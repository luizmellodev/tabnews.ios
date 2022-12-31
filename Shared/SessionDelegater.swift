//
//  SessionDelegater.swift
//  tabnewsios
//
//  Created by Luiz Eduardo Mello dos Reis on 31/12/22.
//
import Combine
import WatchConnectivity

class SessionDelegater: NSObject, WCSessionDelegate {
    let likedContent: PassthroughSubject<[ContentModel], Never>
    
    init(likedContent: PassthroughSubject<[ContentModel], Never>) {
        self.likedContent = likedContent
        super.init()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Protocol comformance only
        // Not needed for this demo
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async {
            if let contentList = message["likedcontent"] as? [ContentModel] {
                self.likedContent.send(contentList)
            } else {
                print("There was an error")
            }
        }
    }
    
    // iOS Protocol comformance
    // Not needed for this demo otherwise
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Activate the new session after having switched to a new watch.
        session.activate()
    }
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    #endif
}
