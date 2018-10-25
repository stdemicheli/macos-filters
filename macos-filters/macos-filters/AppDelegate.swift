//
//  AppDelegate.swift
//  macos-filters
//
//  Created by De MicheliStefano on 25.10.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBAction func open(_ sender: Any) {
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.begin { (response) in
            if response == .OK {
                guard let imageUrl = panel.url else { return }
                NotificationCenter.default.post(name: .imageWasOpened, object: nil, userInfo: ["imageUrl": imageUrl])
            }
            panel.close()
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }

}

extension Notification.Name {
    static let imageWasOpened = Notification.Name("imageWasOpened")
}
