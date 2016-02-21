//
//  InterfaceController.swift
//  ClimateControlWatch Extension
//
//  Created by Tarang khanna on 2/20/16.
//  Copyright © 2016 akshat. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    
    @IBOutlet var fieldImageView: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if WCSession.isSupported() {
            WCSession.defaultSession().delegate = self
            WCSession.defaultSession().activateSession()
        }
    }
    
    func session(session: WCSession, didReceiveMessageData messageData: NSData, replyHandler: (NSData) -> Void) {
        
        guard let image = UIImage(data: messageData) else {
            return
        }
        
        // throw to the main queue to upate properly
        dispatch_async(dispatch_get_main_queue()) { [weak self] in
            // update your UI here
            self!.fieldImageView.setImage(image)
        }
        
        replyHandler(messageData)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}