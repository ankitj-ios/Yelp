//
//  YelpBusiness.swift
//  Yelp
//
//  Created by Ankit Jasuja on 7/23/16.
//  Copyright © 2016 Ankit Jasuja. All rights reserved.
//

import Foundation
import AFNetworking

class YelpBusiness : CustomStringConvertible {
    
    var businessImageUrl : String?
    var ratingsImageUrl : String?
    
    var name : String?
    var reviewCount : Int?
    var categories : String?
    var address : String?
    var distance : String?
    var costCatory : String?
    
    init(responseDictionary : NSDictionary) {
        adaptToBusiness(responseDictionary)
    }
    
    static func getBusinesses(yelpFilterSettings : YelpFilterSettings, completion: ([YelpBusiness]) -> Void) -> Void {
//        YelpClient.sharedInstance.getBusinesses(yelpFilterSettings
//            , successCallBack: <#T##(NSDictionary) -> Void#>)
        YelpClient.sharedInstance.getBusinesses(yelpFilterSettings) { (response) in
            // adapt response to businesses array and call completion
            let businesses : [YelpBusiness] = self.adaptResponse(response)
            completion(businesses)
        }
    }
    
    static func adaptResponse(responseDictionary : NSDictionary) -> [YelpBusiness] {
        var businesses : [YelpBusiness] = []
        let businessesResponse = responseDictionary["businesses"] as! [NSDictionary]
        for businessResponse in businessesResponse {
            businesses.append(YelpBusiness(responseDictionary: businessResponse))
        }
        return businesses
    }
    
    func adaptToBusiness(businessResponse : NSDictionary) -> Void {
        /*logic of init of Buisiness*/
        name = businessResponse["name"] as? String
        reviewCount = businessResponse["review_count"] as? Int
        distance = "0.7 mi"
        costCatory = "$$"
        
        /* set address */
        let location = businessResponse["location"] as? NSDictionary
        var address = ""
        if location != nil {
            let addressArray = location!["address"] as? NSArray
            if addressArray != nil && addressArray!.count > 0 {
                address = addressArray![0] as! String
            }
            
            let neighborhoods = location!["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0 {
                if !address.isEmpty {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
        }
        self.address = address

        /* set categories*/
        let categoriesArray = businessResponse["categories"] as? [[String]]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joinWithSeparator(", ")
        } else {
            categories = nil
        }
        
        businessImageUrl = businessResponse["image_url"] as? String
        ratingsImageUrl = businessResponse["rating_img_url"] as? String
    }
    var description: String {
        return ""
    }
}