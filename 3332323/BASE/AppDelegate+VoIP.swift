//
//  AppDelegate+VoIP.swift
//  3332323
//
//  Created by dd on 18/2/22.
//

import Foundation
import PushKit

extension AppDelegate {











    // Register for VoIP notifications
    func voipRegistration () {
//        let mainQueue = dispatch_get_main_queue()
//        // Create a push registry object
//        let voipRegistry: PKPushRegistry = PKPushRegistry(mainQueue)
//        // Set the registry's delegate to self
//        voipRegistry.delegate = self
//        // Set the push type to VoIP
//        voipRegistry.desiredPushTypes = [PKPushTypeVoIP]
    }

    func pushRegistry(registry: PKPushRegistry!, didUpdatePushCredentials credentials: PKPushCredentials!, forType type: String!) {
        // Register VoIP push token (a property of PKPushCredentials) with server
    }

    func pushRegistry(registry: PKPushRegistry!, didReceiveIncomingPushWithPayload payload: PKPushPayload!, forType type: String!) {
        // Process the received push
    }



}
