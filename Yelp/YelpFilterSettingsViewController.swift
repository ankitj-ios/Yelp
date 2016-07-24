//
//  YelpFilterSettingsViewController.swift
//  Yelp
//
//  Created by Ankit Jasuja on 7/23/16.
//  Copyright © 2016 Ankit Jasuja. All rights reserved.
//

import UIKit

protocol YelpFilterSettingsDelegate : class {
    func onSearch(yelpFilterSettings : YelpFilterSettings)
}

class YelpFilterSettingsViewController: UIViewController {
    
    weak var delegate : YelpFilterSettingsDelegate?
    
    var yelpFilterSettings : YelpFilterSettings!
    
    @IBAction func onSearchButtonClick(sender: AnyObject) {
        updateYelpFilterSettings()
        delegate?.onSearch(yelpFilterSettings)
        dismissViewControllerAnimated(true, completion: nil)
        print("search button clicked ... ")
    }
    
    func updateYelpFilterSettings() {
        yelpFilterSettings.sortMode = YelpSortMode.HighestRated
    }
    
    @IBAction func onCancelButtonClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        print("cancel button clicked ... ")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
