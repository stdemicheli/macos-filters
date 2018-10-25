//
//  ImageViewController.swift
//  macos-filters
//
//  Created by De MicheliStefano on 25.10.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Cocoa

class ImageViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var filterTableView: NSScrollView!
    @IBOutlet weak var parameterTableView: NSScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidOpenImage(_:)), name: .imageWasOpened, object: nil)
    }
    
    @objc func onDidOpenImage(_ notification: Notification) {
        guard let imageUrl = notification.userInfo?["imageUrl"] as? URL else { return }
        
        imageView.image = NSImage(byReferencing: imageUrl)
    }
    
}
