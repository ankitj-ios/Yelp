//
//  YelpClient.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

import AFNetworking
import BDBOAuth1Manager

// You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
//let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
//let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
//let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
//let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"

let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"


enum YelpSortMode: Int {
    case BestMatched = 0, Distance, HighestRated
}

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    class var sharedInstance : YelpClient {
        struct Static {
            static var token : dispatch_once_t = 0
            static var instance : YelpClient? = nil
        }
        
        dispatch_once(&Static.token) {
            Static.instance = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        }
        return Static.instance!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        let baseUrl = NSURL(string: "https://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        let token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    /*
     1. Build request from input query and filters
     2. Make a call to api.
     3. on success, callback a function with response dictionary
     4. on failure, callback a function with error details.
     */
    func getBusinesses(yelpFilterSettings : YelpFilterSettings,
                       successCallBack : (NSDictionary) -> Void) -> Void {
       let params = createParameters(yelpFilterSettings)
        print(yelpFilterSettings)
       self.GET("search", parameters: params,
            success: { (requestOperation, responseObject) in
                print("successfully called yelp api ... ")
                successCallBack(responseObject as! NSDictionary)
            },
            failure: {
                (httpRequestOperation, error) -> Void in
                print(error)
            })
    }
    
    func createParameters(yelpFilterSettings : YelpFilterSettings) -> [String : AnyObject] {
        var parameters : [String : AnyObject] = [:]

//        parameters["location"] = "sf"
        parameters["ll"] = "37.785771,-122.406165"
        let term = yelpFilterSettings.searchTerm
        let sort = yelpFilterSettings.sortMode
        let categories = yelpFilterSettings.categories
        let deals = yelpFilterSettings.deals
        
        parameters["term"] = term ?? ""
        
        if sort != nil {
            parameters["sort"] = sort!.rawValue
        }

        if categories != nil && categories!.count > 0 {
            parameters["category_filter"] = (categories!).joinWithSeparator(",")
        }

        if deals != nil {
            parameters["deals_filter"] = deals!
        }
        
        
        return parameters
    }
    
//    func searchWithTerm(term: String, completion: ([YelpBusiness]!, NSError!) -> Void) -> AFHTTPRequestOperation {
//        return searchWithTerm(term, sort: nil, categories: nil, deals: nil, completion: completion)
//    }
//    
//    func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: ([YelpBusiness]!, NSError!) -> Void) -> AFHTTPRequestOperation {
//        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
//        
//        // Default the location to San Francisco
//        var parameters: [String : AnyObject] = ["term": term, "ll": "37.785771,-122.406165"]
//        
//        if sort != nil {
//            parameters["sort"] = sort!.rawValue
//        }
//        
//        if categories != nil && categories!.count > 0 {
//            parameters["category_filter"] = (categories!).joinWithSeparator(",")
//        }
//        
//        if deals != nil {
//            parameters["deals_filter"] = deals!
//        }
//        
//        print(parameters)
//        
//        return self.GET("search", parameters: parameters, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
//            let dictionaries = response["businesses"] as? [NSDictionary]
//            if dictionaries != nil {
//                completion(Business.businesses(array: dictionaries!), nil)
//            }
//            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError!) -> Void in
//                completion(nil, error)
//        })!
//    }
}
