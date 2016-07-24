//
//  YelpFilterSettings.swift
//  Yelp
//
//  Created by Ankit Jasuja on 7/23/16.
//  Copyright © 2016 Ankit Jasuja. All rights reserved.
//

import Foundation

class YelpFilterSettings: CustomStringConvertible {
    
    var searchTerm : String?
    
    init() {
        searchTerm = ""
    }
    
    var description: String {
        return searchTerm!
    }
}
