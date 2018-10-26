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
    
    init(name: String, minValue: Int, maxValue: Int) {
        self.name = name
        self.minValue = minValue
        self.maxValue = maxValue
    }
    
    @objc dynamic var name: String
    @objc dynamic var minValue: Int
    @objc dynamic var maxValue: Int
    
}
