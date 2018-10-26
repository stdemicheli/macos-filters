//
//  Filter.swift
//  macos-filters
//
//  Created by De MicheliStefano on 25.10.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Foundation
import CoreImage

// Any properties that are bound to the UI will have to be @objc dynamic
class Filter: NSObject {
    
    init(filter: CIFilter, attributes: [Attribute]? = nil) {
        self.filter = filter
        self.attributes = attributes
    }
    
    @objc dynamic var filter: CIFilter
    @objc dynamic var attributes: [Attribute]?
    
}

class Attribute: NSObject {
    
    init(name: String, minValue: Double, maxValue: Double, defaultValue: Double, filter: CIFilter) {
        self.name = name
        self.filter = filter
        self.minValue = minValue
        self.maxValue = maxValue
        self.defaultValue = defaultValue
    }
    
    @objc dynamic var name: String
    @objc dynamic var filter: CIFilter
    @objc dynamic var minValue: Double
    @objc dynamic var maxValue: Double
    @objc dynamic var defaultValue: Double {
        didSet {
            NotificationCenter.default.post(name: .attributeValueDidChange, object: nil, userInfo: ["attributeValue": defaultValue,
                                                                                                    "attribute" : self,
                                                                                                    "filter": filter])
        }
    }
    
}
