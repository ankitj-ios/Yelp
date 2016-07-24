//
//  YelpSettingsViewController.swift
//  Yelp
//
//  Created by Ankit Jasuja on 7/24/16.
//  Copyright © 2016 Ankit Jasuja. All rights reserved.
//

import UIKit

protocol YelpSettingsDelegate : class {
    func yelpSettingsSearch(yelpFilterSettings : YelpFilterSettings)
}

class YelpSettingsViewController: UITableViewController {

    @IBOutlet weak var priceControl: UISegmentedControl!
    
    @IBOutlet weak var sortControl: UISegmentedControl!
    
    @IBOutlet weak var dealsSwitch: UISwitch!
    
    /* category filter switches */
    @IBOutlet weak var indianCategorySwitch: UISwitch!
    @IBOutlet weak var chineseCategorySwitch: UISwitch!
    @IBOutlet weak var americanCategorySwitch: UISwitch!
    
    weak var delegate : YelpSettingsDelegate?
    var yelpFilterSettings : YelpFilterSettings!
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        print("cancelled filter changes")
    }
    
    
    
    @IBAction func onSearch(sender: AnyObject) {
        // UI view to settings object
        updateSettings()
        delegate?.yelpSettingsSearch(yelpFilterSettings)
        dismissViewControllerAnimated(true, completion: nil)
        print("search with filter changes")
    }
    
    func updateSettings() -> Void {
        // update settings based on current value of all controllers.
        let sortIndex = sortControl.selectedSegmentIndex
        if sortIndex == 0 {
            yelpFilterSettings.sortMode = YelpSortMode.BestMatched
        } else if sortIndex == 1 {
            yelpFilterSettings.sortMode = YelpSortMode.Distance
        } else {
            yelpFilterSettings.sortMode = YelpSortMode.HighestRated
        }
        yelpFilterSettings.deals = dealsSwitch.on
        
        var updatedCategories : [String] = []
        if (indianCategorySwitch.on) {
            updatedCategories.append("indpak")
        }
        if (chineseCategorySwitch.on) {
            updatedCategories.append("chinese")
        }
        if (americanCategorySwitch.on) {
            updatedCategories.append("newamerican")
        }
        yelpFilterSettings.categories = updatedCategories
    }
    override func viewDidLoad() {
        // settings object to UI view
        let sortMode = yelpFilterSettings.sortMode!
        switch sortMode {
        case YelpSortMode.BestMatched:
            sortControl.selectedSegmentIndex = 0
        case YelpSortMode.Distance:
            sortControl.selectedSegmentIndex = 1
        case YelpSortMode.HighestRated:
            sortControl.selectedSegmentIndex = 2
        }
        
        dealsSwitch.on = yelpFilterSettings.deals!
        
        for category in yelpFilterSettings.categories! {
            if (category == "indpak") {
                indianCategorySwitch.on = true
            }
            if (category == "chinese") {
                chineseCategorySwitch.on = true
            }
            if (category == "newamerican") {
                americanCategorySwitch.on = true
            }
        }
    }
    
    
    override func tableView(tableView: UITableView,
                            didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tableViewCell = tableView.cellForRowAtIndexPath(indexPath)
        tableViewCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
}
