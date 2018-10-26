//
//  ImageViewController.swift
//  macos-filters
//
//  Created by De MicheliStefano on 25.10.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Cocoa

class ImageViewController: NSViewController, NSTableViewDelegate {

    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var filterTableView: NSTableView!
    @IBOutlet weak var attributesTableView: NSTableView!
    
    @IBOutlet var imageController: NSArrayController!
    // Add attributes of filters
    @IBOutlet var filterController: NSArrayController!
    
    @objc dynamic var filters = [Filter]()
    // @objc dynamic var attributes = [Attribute]()
    var ciFilters = [CIFilter(name: "CIGaussianBlur")!, CIFilter(name: "CIColorControls")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterTableView.delegate = self
        
        // Add the filters array to the NSArrayController. NSArrayController will then bind data to the table view.
        for ciFilter in ciFilters {
            let filterModel = Filter(filter: ciFilter)
            filters.append(filterModel)
            
            //filterController.add(contentsOf: ciFilter.inputKeys)
        }
        imageController.add(contentsOf: filters)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidOpenImage(_:)), name: .imageWasOpened, object: nil)
    }
    
    @objc func onDidOpenImage(_ notification: Notification) {
        guard let imageUrl = notification.userInfo?["imageUrl"] as? URL else { return }
        
        imageView.image = NSImage(byReferencing: imageUrl)
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        // Add the ciFilters inputKeys to the filterController
        let filter = ciFilters[row]
        filterController.content = nil
        filterController.add(contentsOf: filter.inputKeys)
        return true
    }
    
}
