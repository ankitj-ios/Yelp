//
//  YelpSearchViewController.swift
//  Yelp
//
//  Created by Ankit Jasuja on 7/23/16.
//  Copyright © 2016 Ankit Jasuja. All rights reserved.
//

import UIKit

class YelpSearchViewController: UIViewController {

    @IBOutlet weak var yelpBusinessTableView: UITableView!
    
    var businesses : [YelpBusiness] = []
    
    var filterSettings : YelpFilterSettings = YelpFilterSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yelpBusinessTableView.dataSource = self
        yelpBusinessTableView.delegate = self
        
        yelpBusinessTableView.rowHeight = UITableViewAutomaticDimension
        yelpBusinessTableView.estimatedRowHeight = 120
        
        print("search view loaded ... ")
        YelpBusiness.getBusinesses(filterSettings) { (yelpBusinesses) in
            print("got businesses on search view ... ")
            self.businesses = yelpBusinesses
            self.yelpBusinessTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension YelpSearchViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let business = businesses[indexPath.row]
        let businessCell = tableView.dequeueReusableCellWithIdentifier("YelpBusinessCell") as! YelpBusinessCell
        setDataInCell(businessCell, business: business)
        return businessCell
    }
    
    func setDataInCell(yelpBusinessCell : YelpBusinessCell, business : YelpBusiness) -> Void {
        yelpBusinessCell.nameLabel.text = business.name
        yelpBusinessCell.addressLabel.text = business.address
        yelpBusinessCell.categoryLabel.text = business.categories
        yelpBusinessCell.reviewCountLabel.text = String(business.reviewCount!) + " Reviews"
        yelpBusinessCell.distanceLabel.text = business.distance
        yelpBusinessCell.costCategoryLabel.text = business.costCatory
        let businessImageRequest = NSURLRequest(URL: NSURL(string: business.businessImageUrl!)!)
        let ratingsImageRequest = NSURLRequest(URL: NSURL(string: business.ratingsImageUrl!)!)
        yelpBusinessCell.businessImageView.setImageWithURLRequest(businessImageRequest, placeholderImage: nil, success: { (businessImageRequest, businessImageResponse, businessImage) in
                yelpBusinessCell.businessImageView.image = businessImage
            }) { (businessImageRequest, businessImageResponse, error) in
                print(error)
        }
        yelpBusinessCell.ratingsImageView.setImageWithURLRequest(ratingsImageRequest, placeholderImage: nil, success: { (ratingsImageRequest, ratingsImageResponse, ratingsImage) in
            yelpBusinessCell.ratingsImageView.image = ratingsImage
        }) { (ratingsImageRequest, ratingsImageResponse, error) in
            print(error)
        }
    }
}