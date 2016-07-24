//
//  YelpFilterSettingsViewController.swift
//  Yelp
//
//  Created by Ankit Jasuja on 7/23/16.
//  Copyright © 2016 Ankit Jasuja. All rights reserved.
//

import UIKit

class YelpFilterSettingsViewController: UIViewController {

    
    @IBAction func onSearchButtonClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        print("search button clicked ... ")
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
