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
    var sortMode : YelpSortMode?
    var categories : [String]?
    var deals : Bool?
    
    init() {
        searchTerm = "thai"
        sortMode = YelpSortMode.BestMatched
        categories = []
        deals = false
    }
    
    var description: String {
        var categoriesString = ""
        if categories != nil && categories!.count > 0 {
           categoriesString  = (categories!).joinWithSeparator(",")
        }
        return searchTerm!
            + String(sortMode!.rawValue)
            + categoriesString
            + String(deals!)
    }
}
