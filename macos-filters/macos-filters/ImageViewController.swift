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
    let filterTableViewId = NSUserInterfaceItemIdentifier(rawValue: "filterTableView")
    @IBOutlet weak var attributesTableView: NSTableView!
    let attributesTableViewId = NSUserInterfaceItemIdentifier(rawValue: "attributesTableView")
    
    @IBOutlet var imageController: NSArrayController!
    // Add attributes of filters
    @IBOutlet var filterController: NSArrayController!
    
    @objc dynamic var filters = [Filter]()
    // @objc dynamic var attributes = [Attribute]()
    var ciFilters = [CIFilter(name: "CIGaussianBlur")!, CIFilter(name: "CIColorControls")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterTableView.delegate = self
        filterTableView.identifier = filterTableViewId
        attributesTableView.delegate = self
        attributesTableView.identifier = attributesTableViewId
        
        // Add the filters array to the NSArrayController. NSArrayController will then bind data to the table view.
        for ciFilter in ciFilters {
            let filterModel = Filter(filter: ciFilter)
            filters.append(filterModel)
            
            //filterController.add(contentsOf: ciFilter.inputKeys)
        }
        imageController.add(contentsOf: filters)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidOpenImage(_:)), name: .imageWasOpened, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(onChangedAttributeValue(_:)), name: .attributeValueDidChange, object: nil)
    }
    
    @objc func onDidOpenImage(_ notification: Notification) {
        guard let imageUrl = notification.userInfo?["imageUrl"] as? URL else { return }
        
        imageView.image = NSImage(byReferencing: imageUrl)
    }
    
    @objc func onChangedAttributeValue(_ notification: Notification) {
        guard let attributeValue = notification.userInfo?["attributeValue"] as? Double, let attribute = notification.userInfo?["attribute"] as? Attribute else { return }
        
        print(attributeValue)
        print(attribute)
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        if tableView.identifier == filterTableViewId {
            let filter = ciFilters[row]
            // Add the ciFilters inputKeys to the filterController
            filterController.content = nil
            var attributes = [Attribute]()
            for input in filter.inputKeys {
                if let attribute = filter.attributes[input] as? [String : Any],
                    let minValue = attribute[kCIAttributeSliderMin] as? Double,
                    let maxValue = attribute[kCIAttributeSliderMax] as? Double,
                    let defaultValue = attribute[kCIAttributeDefault] as? Double {
                    attributes.append(Attribute(name: input, minValue: minValue, maxValue: maxValue, defaultValue: defaultValue))
                }
            }
            filterController.add(contentsOf: attributes)
            return true
        } else if tableView.identifier == attributesTableViewId {
//            let attributes = filterController.content as! [Attribute]
//            let attribute = attributes[row]
            return true
        } else {
            return false
        }
    }
    
}
