//
//  Filter.swift
//  macos-filters
//
//  Created by De MicheliStefano on 25.10.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Foundation
import CoreImage

struct Filter {
    
    var filter: CIFilter
    var attributes: [Attribute]
    
}

struct Attribute {
    
    var name: String
    var minValue: Int
    var maxValue: Int
    
}
